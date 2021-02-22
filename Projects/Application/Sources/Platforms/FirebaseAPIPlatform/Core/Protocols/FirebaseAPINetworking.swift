import Foundation
import RxSwift

protocol FirebaseAPINetworking {
  func create(uid: String, collection: String, dictionary: [String: Any]) -> Single<Void>
  func get<T: Decodable>(uid: String, collection: String) -> Single<T>
  func get<T: Decodable>(collection: String) -> Single<[T]>
}
