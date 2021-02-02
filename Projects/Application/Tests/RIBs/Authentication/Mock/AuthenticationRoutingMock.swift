import RIBs
import RxRelay
import RxSwift
@testable import Application

// MARK: - AuthenticationRoutingMock

class AuthenticationRoutingMock: RoutingMock {
  var cleanupViewsCallCount = 0
  var cleanupViewsHandler: (() -> Void)?
  var routeLoginCallCount = 0
  var routeLoginHandler: (() -> Void)?
}

// MARK: AuthenticationRouting

extension AuthenticationRoutingMock: AuthenticationRouting {
  func cleanupViews() {
    cleanupViewsCallCount += 1
    cleanupViewsHandler?()
  }

  func routeLogin() {
    routeLoginCallCount += 1
    routeLoginHandler?()
  }
}
