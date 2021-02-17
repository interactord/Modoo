import UIKit
@testable import Application

class RootViewControllerSpy: RootViewController {

  var presentViewControllerTarget: UIViewController?

  override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    super.present(viewControllerToPresent, animated: flag, completion: completion)
    presentViewControllerTarget = viewControllerToPresent
  }

  override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
    super.dismiss(animated: flag, completion: completion)
    presentViewControllerTarget = nil
  }
}
