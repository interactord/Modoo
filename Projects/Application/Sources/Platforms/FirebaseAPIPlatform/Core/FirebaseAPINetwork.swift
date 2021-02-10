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
}
