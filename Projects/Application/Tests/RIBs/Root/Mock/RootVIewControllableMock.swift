import RIBs
import RxRelay
import RxSwift
import UIKit
@testable import Application

// MARK: - RootViewControllableMock

class RootViewControllableMock: ViewControllableMock, RootPresentable {
  // MARK: Variables

  var listener: RootPresentableListener?

  // MARK: Function Handler

  var presentHandler: (() -> Void)?
  var presentCallCount: Int = 0
  var dismissHandler: (() -> Void)?
  var dismissCallCount: Int = 0
  var pushRootViewControllerCallCount: Int = 0
  var pushRootViewControllerHandler: (() -> Void)?
  var popRootViewControllerCallCount: Int = 0
  var popRootViewControllerHandler: (() -> Void)?
  var viewControllers: Int = 0
}

// MARK: RootViewControllable

extension RootViewControllableMock: RootViewControllable {
  func present(viewController _: ViewControllable) {
    presentCallCount += 1
    presentHandler?()
  }

  func dismiss(viewController _: ViewControllable) {
    dismissCallCount += 1
    dismissHandler?()
  }

  func pushRootViewController(viewController: ViewControllable) {
    viewControllers += 1
    pushRootViewControllerCallCount += 1
    pushRootViewControllerHandler?()
  }

  func popRootViewController(viewController: ViewControllable) {
    viewControllers = 0
    popRootViewControllerCallCount += 1
    popRootViewControllerHandler?()
  }
}
