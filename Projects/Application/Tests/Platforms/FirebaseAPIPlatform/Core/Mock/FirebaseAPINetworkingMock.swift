import Foundation
import Promises

@testable import Application

class FirebaseAPINetworkingMock: FirebaseAPINetworking {

  var networkState: TestUtil.NetworkState = .succeed

  func create(uid: String, collection: String, dictionary: [String: Any]) -> Promise<Void> {
    .init { fulfill, reject in
      switch self.networkState {
      case .succeed:
        return fulfill(Void())
      case .failed:
        reject(TestUtil.TestErrors.testMockError)
      }
    }
  }

}
