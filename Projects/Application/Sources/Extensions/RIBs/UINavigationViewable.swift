import RIBs
import UIKit

// MARK: - UINavigationViewable

protocol UINavigationViewable {
  func push(viewControllable: ViewControllable, animated: Bool)
  func pop(viewControllable: ViewControllable, animated: Bool)
}

extension UINavigationViewable where Self: UIViewController {
  func push(viewControllable: ViewControllable, animated: Bool) {
    navigationController?.pushViewController(
      viewControllable.uiviewController,
      animated: animated)
  }

  func pop(viewControllable: ViewControllable, animated: Bool) {
    viewControllable.uiviewController.navigationController?.popViewController(animated: animated)
  }
}
