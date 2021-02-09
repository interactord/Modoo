import FirebaseFirestore
import Foundation
import Promises

struct FirebaseAPINetwork: FirebaseAPINetworking {

  func create(uid: String, collection: String, dictionary: [String: Any]) -> Promise<Void> {
    .init { fulfill, reject in
      Firestore.firestore().collection(collection).document(uid).setData(dictionary) { error in
        if let error = error { return reject(error) }
        fulfill(Void())
      }
    }
  }
}
