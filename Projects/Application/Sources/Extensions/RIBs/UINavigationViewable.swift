import RIBs
import UIKit

// MARK: - UINavigationViewable

protocol UINavigationViewable {
  func push(viewControllable: ViewControllable, animated: Bool)
  func pop(viewControllable: ViewControllable, animated: Bool)
  func present(viewControllable: ViewControllable, isFullScreenSize: Bool, animated: Bool)
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

  func present(viewControllable: ViewControllable, isFullScreenSize: Bool, animated: Bool) {
    guard isFullScreenSize else {
      present(viewControllable.uiviewController, animated: animated)
      return
    }

    let uiViewController = viewControllable.uiviewController
    uiViewController.isModalInPresentation = true
    uiViewController.modalPresentationStyle = .fullScreen
    present(uiViewController, animated: animated)
  }
}
