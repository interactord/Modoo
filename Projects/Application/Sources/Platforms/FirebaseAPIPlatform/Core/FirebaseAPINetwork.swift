import FirebaseFirestore
import Foundation
import RxSwift

struct FirebaseAPINetwork: FirebaseAPINetworking {

  func create(uid: String, collection: String, dictionary: [String: Any]) -> Single<Void> {
    .create { single in
      Firestore.firestore()
        .collection(collection)
        .document(uid)
        .setData(dictionary) { error in
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
}
