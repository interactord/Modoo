import Foundation
import RxSwift

protocol FirebaseAPINetworking {
  func create(rootUID: String, rootCollection: String, dictionary: [String: Any]) -> Single<Void>
  func create(rootUID: String, rootCollection: String, documentCollection: String, documentUID: String, dictionary: [String: Any]) -> Single<Void>
  func create(rootCollection: String, dictionary: [String: Any]) -> Single<Void>
  func delete(rootUID: String, rootCollection: String, documentCollection: String, documentUID: String) -> Single<Void>
  func get<T: Decodable>(uid: String, collection: String) -> Single<T>
  func get<T: Decodable>(collection: String) -> Single<[T]>
  func find(rootUID: String, rootCollection: String, documentCollection: String, documentUID: String) -> Single<Bool>
  func count(rootUID: String, rootCollection: String, documentCollection: String) -> Single<Int>
}
