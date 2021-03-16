import FirebaseFirestore
import Foundation
import RxSwift

struct FirebaseAPINetwork: FirebaseAPINetworking {

  func create(rootUID: String, rootCollection: String, dictionary: [String: Any]) -> Single<Void> {
    .create { single in
      Firestore.firestore()
        .collection(rootCollection)
        .document(rootUID)
        .setData(dictionary) { error in
          if let error = error { single(.failure(error)) }
          single(.success(Void()))
        }

      return Disposables.create()
    }
  }

  func create(rootUID: String, rootCollection: String, documentCollection: String, documentUID: String, dictionary: [String: Any]) -> Single<Void> {
    .create { single in
      Firestore.firestore()
        .collection(rootCollection)
        .document(rootUID)
        .collection(documentCollection)
        .document(documentUID)
        .setData(dictionary) { error in
          if let error = error { single(.failure(error)) }
          single(.success(Void()))
        }

      return Disposables.create()
    }
  }

  func create(rootCollection: String, dictionary: [String: Any]) -> Single<Void> {
    .create { single in
      Firestore.firestore()
        .collection(rootCollection)
        .addDocument(data: dictionary) { error in
          if let error = error { single(.failure(error)) }
          single(.success(Void()))
        }

      return Disposables.create()
    }
  }

  func delete(rootUID: String, rootCollection: String, documentCollection: String, documentUID: String) -> Single<Void> {
    .create { single in
      Firestore.firestore()
        .collection(rootCollection)
        .document(rootUID)
        .collection(documentCollection)
        .document(documentUID)
        .delete { error in
          if let error = error { single(.failure(error)) }
          single(.success(Void()))
        }

      return Disposables.create()
    }
  }

  func get<T: Decodable>(uid: String, collection: String) -> Single<T> {
    .create { single in
      Firestore.firestore()
        .collection(collection)
        .document(uid)
        .getDocument { snapshot, error in
          if let error = error { single(.failure(error)) }
          guard let data = snapshot?.data() else { return single(.failure(FirebaseError.noData)) }
          do {
            let model = try T.init(from: data)
            single(.success(model))
          } catch {
            single(.failure(error))
          }
        }

      return Disposables.create()
    }
  }

  func get<T: Decodable>(collection: String) -> Single<[T]> {
    .create { single in
      Firestore.firestore()
        .collection(collection)
        .getDocuments { snapshot, error in
          if let error = error { single(.failure(error)) }
          guard let documents = snapshot?.documents else { return single(.failure(FirebaseError.noDocumnets)) }

          let objects: [T] = documents.compactMap { try? T.init(from: $0.data()) }
          single(.success(objects))

        }

      return Disposables.create()
    }
  }

  func get<T: Decodable>(collection: String, orderBy key: String, descending: Bool) -> Single<[T]> {
    .create { single in
      Firestore.firestore()
        .collection(collection)
        .order(by: key, descending: descending)
        .getDocuments { snapshot, error in
          if let error = error { single(.failure(error)) }
          guard let documents = snapshot?.documents else { return single(.failure(FirebaseError.noDocumnets)) }

          let objects: [T] = documents.compactMap { querySnapShot in
            var newQuerySnapShot = querySnapShot.data()

            if let timeStamp = newQuerySnapShot["timestamp"] as? Timestamp {
              newQuerySnapShot["timestamp"] = timeStamp.dateValue().timeIntervalSince1970
            }

            newQuerySnapShot["id"] = querySnapShot.documentID

            return try? T.init(from: newQuerySnapShot)
          }
          single(.success(objects))
        }

      return Disposables.create()
    }
  }

  func get<T: Decodable>(collection: String, orderBy key: String, whereFeild: [String: String], descending: Bool) -> Single<[T]> {
    .create { single in
      Firestore.firestore()
        .collection(collection)
        .order(by: key, descending: descending)
        .whereField(whereFeild.first?.key ?? "", isEqualTo: whereFeild.first?.value ?? "")
        .getDocuments { snapshot, error in
          if let error = error { single(.failure(error)) }
          guard let documents = snapshot?.documents else { return single(.failure(FirebaseError.noDocumnets)) }

          let objects: [T] = documents.compactMap { querySnapShot in
            var newQuerySnapShot = querySnapShot.data()

            if let timeStamp = newQuerySnapShot["timestamp"] as? Timestamp {
              newQuerySnapShot["timestamp"] = timeStamp.dateValue().timeIntervalSince1970
            }

            newQuerySnapShot["id"] = querySnapShot.documentID

            return try? T.init(from: newQuerySnapShot)
          }
          single(.success(objects))
        }

      return Disposables.create()
    }
  }

  func find(rootUID: String, rootCollection: String, documentCollection: String, documentUID: String) -> Single<Bool> {
    .create { single in
      Firestore.firestore()
        .collection(rootCollection)
        .document(rootUID)
        .collection(documentCollection)
        .document(documentUID)
        .getDocument { snapShot, error in
          if let error = error { single(.failure(error)) }
          let result = snapShot?.exists
          single(.success(result ?? false))
        }

      return Disposables.create()
    }
  }

  func count(rootUID: String, rootCollection: String, documentCollection: String) -> Single<Int> {
    .create { single in
      Firestore.firestore()
        .collection(rootCollection)
        .document(rootUID)
        .collection(documentCollection)
        .getDocuments { snapShot, error in
          if let error = error { single(.failure(error)) }
          let count = snapShot?.documents.count
          single(.success(count ?? 0))
        }

      return Disposables.create()
    }
  }

}
