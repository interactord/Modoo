import RIBs
import RxRelay
import RxSwift
import UIKit
@testable import Application

// MARK: - OnboardViewControllableMock

class OnboardViewControllableMock: ViewControllableMock, OnboardPresentable {
  var listener: OnboardPresentableListener?

  var setVewControllersCallCount = 0
  var setVewControllersHandler: (() -> Void)?
}

// MARK: OnboardViewControllable

extension OnboardViewControllableMock: OnboardViewControllable {

  func setVewControllers(viewControllers: [ViewControllable]) {
    setVewControllersCallCount += 1
    setVewControllersHandler?()
  }

}
