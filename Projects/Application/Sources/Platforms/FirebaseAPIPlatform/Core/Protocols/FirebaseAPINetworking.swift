import Foundation
import RxSwift

protocol FirebaseAPINetworking {
  func create(uid: String, collection: String, dictionary: [String: Any]) -> Single<Void>
}
