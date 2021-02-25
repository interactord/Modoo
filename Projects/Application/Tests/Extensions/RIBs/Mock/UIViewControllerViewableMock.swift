import RIBs
import UIKit
@testable import Application

// MARK: - UIViewControllerViewableMock

final class UIViewControllerViewableMock: UIViewController {

  var presentCallCount = 0
  var presentHandler: (() -> Void)?
  var dismissCallCount = 0
  var dismissHandler: (() -> Void)?

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
}

// MARK: ViewControllable

extension UIViewControllerViewableMock: ViewControllable {
  var uiviewController: UIViewController { self }
}

// MARK: UIViewControllerViewable

extension UIViewControllerViewableMock: UIViewControllerViewable {
}
