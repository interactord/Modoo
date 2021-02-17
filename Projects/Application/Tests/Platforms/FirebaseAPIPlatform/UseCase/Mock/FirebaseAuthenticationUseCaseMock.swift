import RxSwift
import UIKit

@testable import Application

class FirebaseAuthenticationUseCaseMock: AuthenticationUseCase {

  var networkState: TestUtil.NetworkState = .succeed
  let firebaseAuthenticatingMock = FirebaseAuthenticatingMock()
  let firebaseMediaUploadingMock = FirebaseMediaUploadingMock()
  let firebaseAPINetworkingMock = FirebaseAPINetworkingMock()
  var registerCallCount: Int = 0
  var registerHandler: (() -> Void)?
  var loginCallCount: Int = 0
  var loginHandler: (() -> Void)?
  var logoutCallCount: Int = 0
  var logoutHandler: (() -> Void)?

  var state: TestUtil.AuthenticationState = .unAuthenticated {
    didSet {
      firebaseAuthenticatingMock.state = state
    }
  }

  var authenticationToken: String {
    firebaseAuthenticatingMock.authenticationToken
  }

  func register(domain: RegisterDisplayModel.State) -> Observable<Void> {
    registerCallCount += 1
    registerHandler?()

    return .create { observer in

      switch self.networkState {
      case .succeed:
        observer.onNext(Void())
      case .failed:
        observer.onError(TestUtil.TestErrors.testMockError)
      }

      observer.onCompleted()

      return Disposables.create()
    }
  }

  func login(domain: LoginDisplayModel.State) -> Observable<Void> {
    loginCallCount += 1
    loginHandler?()

    return .create { observer in

      switch self.networkState {
      case .succeed:
        observer.onNext(Void())
      case .failed:
        observer.onError(TestUtil.TestErrors.testMockError)
      }

      observer.onCompleted()

      return Disposables.create()
    }
  }

  func logout() {
    logoutCallCount += 1
    loginHandler?()

    state = .unAuthenticated
  }

}
