import Foundation
import Promises

protocol FirebaseAPINetworking {
  func create(uid: String, collection: String, dictionary: [String: Any]) -> Promise<Void>
}
