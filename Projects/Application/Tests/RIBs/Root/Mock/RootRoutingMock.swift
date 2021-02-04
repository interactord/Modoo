import RIBs
import RxRelay
import RxSwift
@testable import Application

// MARK: - RootRoutingMock

class RootRoutingMock: RoutingMock {

  var cleanupViewCallCount = 0
  var cleanupViewHandler: (() -> Void)?
  var routeToAuthenticationCallCount = 0
  var routeToAuthenticationHandler: (() -> Void)?
  var routeToOnboardCallCount = 0
  var routeToOnboardHandler: (() -> Void)?
}

// MARK: RootRouting

extension RootRoutingMock: RootRouting {

  func cleanupViews() {
    cleanupViewCallCount += 1
    cleanupViewHandler?()
  }

  func routeToAuthentication() {
    routeToAuthenticationCallCount += 1
    routeToAuthenticationHandler?()
  }

  func routeToOnboard() {
    routeToOnboardCallCount += 1
    routeToOnboardHandler?()
  }

}
