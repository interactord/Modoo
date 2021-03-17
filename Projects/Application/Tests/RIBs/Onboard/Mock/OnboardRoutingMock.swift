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
  var routeToCloseCallCount = 0
  var routeToCloseHandler: (() -> Void)?
  var routeToSubFeedCallCount = 0
  var routeToSubFeedHandler: (() -> Void)?
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

  func routeToClose() {
    routeToCloseCallCount += 1
    routeToCloseHandler?()
  }

  func routeToSubFeed() {
    routeToSubFeedCallCount += 1
    routeToSubFeedHandler?()
  }

}
