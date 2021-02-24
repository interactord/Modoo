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

          let users: [T] = documents.compactMap { try? T.init(from: $0.data()) }
          single(.success(users))

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
