import UIKit

import RIBs
import RxRelay
import RxSwift

@testable import Application

// MARK: - AuthenticationViewControllableMock

class AuthenticationViewControllableMock: ViewControllableMock, AuthenticationPresentable {

  var viewControllers = 0
  var setRootViewControllerCallCount = 0
  var setRootViewControllerHandler: (() -> Void)?
  var clearChildViewControllersCallCount = 0
  var clearChildViewControllersHandler: (() -> Void)?
  var pushViewControllerCallCount = 0
  var pushViewControllerHandler: (() -> Void)?
  var popToRootViewControllerCallCount = 0
  var popToRootViewControllerHandler: (() -> Void)?

  var listener: AuthenticationPresentableListener?
}

// MARK: AuthenticationViewControllable

extension AuthenticationViewControllableMock: AuthenticationViewControllable {

  func setRootViewController(viewController: ViewControllable) {
    viewControllers = 1
    setRootViewControllerCallCount += 1
    setRootViewControllerHandler?()
  }

  func pushViewController(viewController: ViewControllable) {
    viewControllers += 1
    pushViewControllerCallCount += 1
    pushViewControllerHandler?()
  }

  func popToRootViewController() {
    viewControllers = 1
    popToRootViewControllerCallCount += 1
    popToRootViewControllerHandler?()
  }
}
