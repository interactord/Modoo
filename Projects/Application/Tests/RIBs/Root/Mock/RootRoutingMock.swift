import RIBs
import RxRelay
import RxSwift
@testable import Application

class RootRoutingMock: RoutingMock, RootRouting {
  var cleanupViewHandler: (() -> Void)?
  var cleanupViewCallCount = 0

  func cleanupViews() {
    cleanupViewCallCount += 1
    cleanupViewHandler?()
  }

  func routeToLoggedIn() {
    let mockRouting = RootRoutingMock(interactable: interactable, viewControllable: viewControllable)
    attachChild(mockRouting)
  }
}
