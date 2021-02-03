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
  var routeToLogIninHandler: (() -> Void)?
  var routeToLoggedInCallCount = 0
  var routeToLoggedIninHandler: (() -> Void)?
  var routeToRegisterCallCount = 0
  var routeToRegisterHandler: (() -> Void)?

}

// MARK: AuthenticationInteractable

extension AuthenticationInteractableMock: AuthenticationInteractable {
  func routeToLogin() {
    routeToLogInCallCount += 1
    routeToLoggedIninHandler?()
  }

  func routeToLoggedIn() {
    routeToLoggedInCallCount += 1
    routeToLoggedIninHandler?()
  }

  func routeToRegister() {
    routeToRegisterCallCount += 1
    routeToRegisterHandler?()
  }

}
