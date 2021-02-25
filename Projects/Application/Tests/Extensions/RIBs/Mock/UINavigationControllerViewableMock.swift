import RIBs
import UIKit
@testable import Application

// MARK: - UINavigationControllerViewableMock

final class UINavigationControllerViewableMock: UINavigationController {

  var pushViewControllerCallCount = 0
  var pushViewControllerHandler: (() -> Void)?
  var popViewControllerCallCount = 0
  var popViewControllerHandler: (() -> Void)?
  var presentCallCount = 0
  var presentHandler: (() -> Void)?
  var dismissCallCount = 0
  var dismissHandler: (() -> Void)?
  var popToRootViewControllerCallCount = 0
  var popToRootViewControllerHandler: (() -> Void)?
  var setViewControllersCallCount = 0
  var setViewControllersHandler: (() -> Void)?

  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    pushViewControllerCallCount += 1
    pushViewControllerHandler?()
    super.pushViewController(viewController, animated: animated)
  }

  override func popViewController(animated: Bool) -> UIViewController? {
    popViewControllerCallCount += 1
    popViewControllerHandler?()
    return super.popViewController(animated: animated)
  }

  override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    presentCallCount += 1
    presentHandler?()
    super.present(viewControllerToPresent, animated: flag, completion: completion)
  }

  override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
    dismissCallCount += 1
    dismissHandler?()
    super.dismiss(animated: flag, completion: completion)
  }

  override func popToRootViewController(animated: Bool) -> [UIViewController]? {
    popToRootViewControllerCallCount += 1
    popToRootViewControllerHandler?()
    return super.popToRootViewController(animated: animated)
  }

  override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
    setViewControllersCallCount += 1
    setViewControllersHandler?()
    super.setViewControllers(viewControllers, animated: animated)
  }

}

// MARK: ViewControllable

extension UINavigationControllerViewableMock: ViewControllable {
  var uiviewController: UIViewController { self }
}

// MARK: UIViewControllerViewable

extension UINavigationControllerViewableMock: UIViewControllerViewable {
}
