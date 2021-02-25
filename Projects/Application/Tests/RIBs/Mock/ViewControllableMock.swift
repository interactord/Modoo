import RIBs
import UIKit
@testable import Application

// MARK: - ViewControllableMock

class ViewControllableMock: ViewControllable {
  var viewControllers = 0
  var presentedViewControllers = 0
  var uiViewControllerCallCount = 0
  var pushCallCount = 0
  var pushHandler: (() -> Void)?
  var popCallCount = 0
  var popHandler: (() -> Void)?
  var presentCallCount = 0
  var presentHandler: (() -> Void)?
  var setRootCallCount = 0
  var setRootHandler: (() -> Void)?
  var clearChildViewControllersCallCount = 0
  var clearChildViewControllersHandler: (() -> Void)?
  var popToRootViewControllableCallCount = 0
  var popToRootViewControllableHandler: (() -> Void)?
  var clearRootViewControllableCallCount = 0
  var clearRootViewControllableHandler: (() -> Void)?
  var dismissCallCount = 0
  var dismissHandler: (() -> Void)?

  var uiviewController = UIViewController() {
    didSet {
      uiViewControllerCallCount += 1
    }
  }
}

// MARK: UIViewControllerViewable

extension ViewControllableMock: UIViewControllerViewable {
  func push(viewControllable: ViewControllable, animated: Bool) {
    viewControllers += 1
    pushCallCount += 1
    pushHandler?()
  }

  func pop(viewControllable: ViewControllable, animated: Bool) {
    popCallCount += 1
    popHandler?()
  }

  func present(viewControllable: ViewControllable, isFullScreenSize: Bool, animated: Bool) {
    presentCallCount += 1
    presentHandler?()
  }

  func setRoot(viewControllable: ViewControllable, animated: Bool) {
    viewControllers = 1
    setRootCallCount += 1
    setRootHandler?()
  }

  func popToRootViewControllable(animated: Bool) {
    viewControllers = 1
    popToRootViewControllableCallCount += 1
    popToRootViewControllableHandler?()
  }

  func clearRootViewControllable(animated: Bool) {
    viewControllers = 0
    clearRootViewControllableCallCount += 1
    clearRootViewControllableHandler?()
  }

  func dismiss(viewControllable: ViewControllable, animated: Bool) {
    presentedViewControllers = 0
    dismissCallCount += 1
    dismissHandler?()
  }
}
