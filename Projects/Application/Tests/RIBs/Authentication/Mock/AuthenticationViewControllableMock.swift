import UIKit

import RIBs
import RxRelay
import RxSwift

@testable import Application

// MARK: - AuthenticationViewControllableMock

class AuthenticationViewControllableMock: ViewControllableMock, AuthenticationPresentable {

  var viewControllers = 0
  var setRootViewControllerCallCount: Int = 0
  var setRootViewControllerHandler: (() -> Void)?
  var clearChildViewControllersCallCount: Int = 0
  var clearChildViewControllersHandler: (() -> Void)?

  var listener: AuthenticationPresentableListener?
}

// MARK: AuthenticationViewControllable

extension AuthenticationViewControllableMock: AuthenticationViewControllable {
  func setRootViewController(viewController: ViewControllable) {
    viewControllers += 1
    setRootViewControllerCallCount += 1
    setRootViewControllerHandler?()
  }

  func clearChildViewControllers(with animated: Bool) {
    viewControllers = 0
    clearChildViewControllersCallCount += 1
    clearChildViewControllersHandler?()
  }
}
