import RIBs
import RxRelay
import RxSwift
@testable import Application

// MARK: - AuthenticationRoutingMock

class AuthenticationRoutingMock: RoutingMock {
  var cleanupViewsCallCount = 0
  var cleanupViewsHandler: (() -> Void)?
  var routeToLoginCallCount = 0
  var routeToLoginHandler: (() -> Void)?
  var routeToRegisterCallCount = 0
  var routeToRegisterHandler: (() -> Void)?
}

// MARK: AuthenticationRouting

extension AuthenticationRoutingMock: AuthenticationRouting {
  func cleanupViews() {
    cleanupViewsCallCount += 1
    cleanupViewsHandler?()
  }

  func routeToLogin() {
    routeToLoginCallCount += 1
    routeToLoginHandler?()
  }

  func routeToRegister() {
    routeToRegisterCallCount += 1
    routeToRegisterHandler?()
  }
}
