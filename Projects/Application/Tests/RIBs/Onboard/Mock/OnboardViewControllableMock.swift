import RIBs
import RxRelay
import RxSwift
import UIKit
@testable import Application

// MARK: - OnboardViewControllableMock

class OnboardViewControllableMock: ViewControllableMock, OnboardPresentable {
  var listener: OnboardPresentableListener?

  var applyVewControllersCallCount = 0
  var applyVewControllersHandler: (() -> Void)?
}

// MARK: OnboardViewControllable

extension OnboardViewControllableMock: OnboardViewControllable {

  func applyVewControllers(viewControllers: [ViewControllable]) {
    applyVewControllersCallCount += 1
    applyVewControllersHandler?()
  }

}
