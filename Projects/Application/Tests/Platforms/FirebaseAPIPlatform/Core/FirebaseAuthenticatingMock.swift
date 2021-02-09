import Foundation
import Promises

@testable import Application

class FirebaseAuthenticatingMock: FirebaseAuthenticating {

  var isSueccedCase = true

  func create(email: String, password: String) -> Promise<String> {
    .init { fulfill, reject in
      guard self.isSueccedCase else {
        return reject(TestUtil.TestErrors.testMockError)
      }
      return fulfill("succeed")
    }
  }

}
