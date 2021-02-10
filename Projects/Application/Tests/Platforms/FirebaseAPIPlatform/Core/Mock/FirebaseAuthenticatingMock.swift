import Foundation
import RxSwift

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

  func create(email: String, password: String) -> Single<String> {
    .create { single in
      switch self.networkState {
      case .succeed:
        single(.success("test"))
      case .failed:
        single(.failure(TestUtil.TestErrors.testMockError))
      }

      return Disposables.create()
    }
  }

}
