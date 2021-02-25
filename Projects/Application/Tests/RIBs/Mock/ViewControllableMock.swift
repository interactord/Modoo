import RIBs
import UIKit
@testable import Application

// MARK: - ViewControllableMock

class ViewControllableMock: ViewControllable {
  var viewControllers = 0
  var uiViewControllerCallCount = 0
  var pushCallCount = 0
  var pushHandler: (() -> Void)?
  var popCallCount = 0
  var popHandler: (() -> Void)?

  var uiviewController = UIViewController() {
    didSet {
      uiViewControllerCallCount += 1
    }
  }
}

// MARK: ViewControlable

extension ViewControllableMock: ViewControlable {
  func push(viewControllable: ViewControllable, animated: Bool) {
    viewControllers += 1
    pushCallCount += 1
    pushHandler?()
  }

  func pop(viewControllable: ViewControllable, animated: Bool) {
    popCallCount += 1
    popHandler?()
  }
}
