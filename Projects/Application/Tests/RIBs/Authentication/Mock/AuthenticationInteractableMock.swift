import RIBs
import RxRelay
import RxSwift

@testable import Application

// MARK: - AuthenticationInteractableMock

class AuthenticationInteractableMock: InteractableMock {

  // MARK: Lifecycle

  override init() {
    super.init()
  }

  // MARK: Internal

  var router: AuthenticationRouting?
  var listener: AuthenticationListener?
  var routeToLogInCallCount = 0
  var routeToLogInHandler: (() -> Void)?
  var routeToOnboardCallCount = 0
  var routeToOnboardHandler: (() -> Void)?
  var routeToRegisterCallCount = 0
  var routeToRegisterHandler: (() -> Void)?

}

// MARK: AuthenticationInteractable

extension AuthenticationInteractableMock: AuthenticationInteractable {

  func routeToLogin() {
    routeToLogInCallCount += 1
    routeToLogInHandler?()
  }

  func routeToOnboard() {
    routeToOnboardCallCount += 1
    routeToOnboardHandler?()
  }

  func routeToRegister() {
    routeToRegisterCallCount += 1
    routeToRegisterHandler?()
  }

}
