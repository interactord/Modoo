import Foundation
import Promises

@testable import Application

class FirebaseAPINetworkingMock: FirebaseAPINetworking {

  var isSueccedCase = true

  func create(uid: String, collection: String, dictionary: [String: Any]) -> Promise<Void> {
    .init { fulfill, reject in
      guard self.isSueccedCase else {
        return reject(TestUtil.TestErrors.testMockError)
      }
      return fulfill(Void())
    }
  }

}
