import RIBs
import RxRelay
import RxSwift
@testable import Application

// MARK: - OnboardRoutingMock

class OnboardRoutingMock: RoutingMock {
  var setViewControllersCallCount = 0
  var setViewControllersHandler: (() -> Void)?
}

// MARK: OnboardRouting

extension OnboardRoutingMock: OnboardRouting {
  func setViewControllers() {
    childrenSetCallCount += 1
    setViewControllersHandler?()
  }

}
