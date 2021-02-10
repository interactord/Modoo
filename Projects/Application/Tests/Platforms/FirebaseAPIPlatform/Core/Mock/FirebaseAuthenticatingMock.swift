import Foundation
import Promises

@testable import Application

class FirebaseAuthenticatingMock: FirebaseAuthenticating {

  var networkState: TestUtil.NetworkState = .succeed
  var state: TestUtil.AuthenticationState = .unAuthenticated

  var authenticationToken: String {
    switch state {
    case .authenticated: return "testToken"
    case .unAuthenticated: return ""
    }
  }

  func create(email: String, password: String) -> Promise<String> {
    .init { fulfill, reject in
      switch self.networkState {
      case .succeed:
        return fulfill("test")
      case .failed:
        reject(TestUtil.TestErrors.testMockError)
      }
    }
  }

}
