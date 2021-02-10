import Foundation
import RxSwift

@testable import Application

class FirebaseAPINetworkingMock: FirebaseAPINetworking {

  var networkState: TestUtil.NetworkState = .succeed

  func create(uid: String, collection: String, dictionary: [String: Any]) -> Single<Void> {
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

}
