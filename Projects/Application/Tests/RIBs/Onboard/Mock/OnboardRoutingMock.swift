import RIBs
import RxRelay
import RxSwift
@testable import Application

// MARK: - OnboardRoutingMock

class OnboardRoutingMock: RoutingMock {
  var setOnceViewControllersCallCount = 0
  var setOnceViewControllersHandler: (() -> Void)?
  var routeToPostCallCount = 0
  var routeToPostHandler: (() -> Void)?
}

// MARK: OnboardRouting

extension OnboardRoutingMock: OnboardRouting {
  func setOnceViewControllers() {
    childrenSetCallCount += 1
    setOnceViewControllersHandler?()
  }

  func routeToPost(image: UIImage) {
    routeToPostCallCount += 1
    routeToPostHandler?()
  }

}
