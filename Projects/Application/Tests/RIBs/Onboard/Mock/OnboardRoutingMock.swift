import RIBs
import RxRelay
import RxSwift
@testable import Application

// MARK: - OnboardRoutingMock

class OnboardRoutingMock: RoutingMock {
  var setOnceViewControllersCallCount = 0
  var setOnceViewControllersHandler: (() -> Void)?
}

// MARK: OnboardRouting

extension OnboardRoutingMock: OnboardRouting {
  func setOnceViewControllers() {
    childrenSetCallCount += 1
    setOnceViewControllersHandler?()
  }

}
