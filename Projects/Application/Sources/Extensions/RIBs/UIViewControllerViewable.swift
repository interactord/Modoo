import RIBs
import UIKit

// MARK: - UIViewControllerViewable

protocol UIViewControllerViewable {
  func push(viewControllable: ViewControllable, animated: Bool)
  func pop(viewControllable: ViewControllable, animated: Bool)
  func present(viewControllable: ViewControllable, isFullScreenSize: Bool, animated: Bool)
  func dismiss(viewControllable: ViewControllable, animated: Bool)
  func setRoot(viewControllable: ViewControllable, animated: Bool)
  func popToRootViewControllable(animated: Bool)
  func clearRootViewControllable(animated: Bool)
}

extension UIViewControllerViewable where Self: UIViewController {
  func push(viewControllable: ViewControllable, animated: Bool) {
    navigationController?.pushViewController(
      viewControllable.uiviewController,
      animated: animated)
  }

  func pop(viewControllable: ViewControllable, animated: Bool) {
    viewControllable.uiviewController.navigationController?.popViewController(animated: animated)
  }

  func present(viewControllable: ViewControllable, isFullScreenSize: Bool, animated: Bool) {
    let uiViewController = viewControllable.uiviewController

    if isFullScreenSize {
      uiViewController.isModalInPresentation = true
      uiViewController.modalPresentationStyle = .fullScreen
    }

    present(uiViewController, animated: animated)
  }

  func setRoot(viewControllable: ViewControllable, animated: Bool) {
    navigationController?.setViewControllers([viewControllable.uiviewController], animated: animated)
  }

  func popToRootViewControllable(animated: Bool) {
    navigationController?.popToRootViewController(animated: animated)
  }

  func dismiss(viewControllable: ViewControllable, animated: Bool) {
    viewControllable.uiviewController.dismiss(animated: animated)
  }

  func clearRootViewControllable(animated: Bool) {
    navigationController?.setViewControllers([], animated: animated)
  }
}

extension UIViewControllerViewable where Self: UINavigationController {
  func push(viewControllable: ViewControllable, animated: Bool) {
    pushViewController(viewControllable.uiviewController, animated: animated)
  }

  func pop(viewControllable: ViewControllable, animated: Bool) {
    viewControllable.uiviewController.navigationController?.popViewController(animated: animated)
  }

  func present(viewControllable: ViewControllable, isFullScreenSize: Bool, animated: Bool) {
    let uiViewController = viewControllable.uiviewController

    if isFullScreenSize {
      uiViewController.isModalInPresentation = true
      uiViewController.modalPresentationStyle = .fullScreen
    }

    present(uiViewController, animated: animated)
  }

  func dismiss(viewControllable: ViewControllable, animated: Bool) {
    viewControllable.uiviewController.dismiss(animated: animated)
  }

  func setRoot(viewControllable: ViewControllable, animated: Bool) {
    setViewControllers([viewControllable.uiviewController], animated: animated)
  }

  func popToRootViewControllable(animated: Bool) {
    popToRootViewController(animated: animated)
  }

  func clearRootViewControllable(animated: Bool) {
    setViewControllers([], animated: animated)
  }
}
