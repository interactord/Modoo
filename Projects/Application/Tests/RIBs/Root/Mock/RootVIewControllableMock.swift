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

  var dismissCallCount = 0
  var dismissHandler: (() -> Void)?
  var setRootCallCount = 0
  var setRootCallCountHandler: (() -> Void)?
  var clearRootViewControllableCallCount = 0
  var clearRootViewControllableHandler: (() -> Void)?
  var presentedViewControllers = 0
}

// MARK: RootViewControllable

extension RootViewControllableMock: RootViewControllable {
  func present(viewControllable: ViewControllable, animated: Bool) {
    presentedViewControllers += 1
    presentCallCount += 1
    presentHandler?()
  }

  func setRoot(viewControllable: ViewControllable, animated: Bool) {
    viewControllers = 1
    setRootCallCount += 1
    setRootCallCountHandler?()
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
