import Foundation
import RxSwift

@testable import Application

class FirebaseAPINetworkingMock: FirebaseAPINetworking {

  var networkState: TestUtil.NetworkState = .succeed
  var jsonObject: [String: Any]?

  func create(rootUID: String, rootCollection: String, dictionary: [String: Any]) -> Single<Void> {
    .create { single in
      switch self.networkState {
      case .succeed:
        single(.success(Void()))
      case .failed:
        single(.failure(TestUtil.TestErrors.testMockError))
      }

      return Disposables.create()
    }
  }

  func create(rootUID: String, rootCollection: String, documentCollection: String, documentUID: String, dictionary: [String: Any]) -> Single<Void> {
    .create { single in
      switch self.networkState {
      case .succeed:
        single(.success(Void()))
      case .failed:
        single(.failure(TestUtil.TestErrors.testMockError))
      }

      return Disposables.create()
    }
  }

  func delete(rootUID: String, rootCollection: String, documentCollection: String, documentUID: String) -> Single<Void> {
    .create { single in
      switch self.networkState {
      case .succeed:
        single(.success(Void()))
      case .failed:
        single(.failure(TestUtil.TestErrors.testMockError))
      }

      return Disposables.create()
    }
  }

  func get<T: Decodable>(uid: String, collection: String) -> Single<T> {
    .create { single in
      guard let jsonObject = self.jsonObject else {
        single(.failure(TestUtil.TestErrors.testMockError))
        return Disposables.create()
      }

      switch self.networkState {
      case .succeed:
        do {
          let model = try T.init(from: jsonObject)
          single(.success(model))
        } catch {
          single(.failure(error))
        }
      case .failed:
        single(.failure(TestUtil.TestErrors.testMockError))
      }

      return Disposables.create()
    }
  }

  func get<T: Decodable>(collection: String) -> Single<[T]> {
    .create { single in
      guard let jsonObject = self.jsonObject else {
        single(.failure(TestUtil.TestErrors.testMockError))
        return Disposables.create()
      }

      switch self.networkState {
      case .succeed:
        do {
          let model = try T.init(from: jsonObject)
          single(.success([model]))
        } catch {
          single(.failure(error))
        }
      case .failed:
        single(.failure(TestUtil.TestErrors.testMockError))
      }

      return Disposables.create()
    }
  }

  func find(rootUID: String, rootCollection: String, documentCollection: String, documentUID: String) -> Single<Bool> {
    .create { single in
      switch self.networkState {
      case .succeed:
        single(.success(true))
      case .failed:
        single(.failure(TestUtil.TestErrors.testMockError))
      }

      return Disposables.create()
    }
  }
}
