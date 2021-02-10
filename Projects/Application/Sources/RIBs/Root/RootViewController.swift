import RIBs
import RxSwift
import UIKit

// MARK: - RootPresentableListener

protocol RootPresentableListener: AnyObject {
}

// MARK: - RootViewController

final class RootViewController: UINavigationController, RootPresentable {

  // MARK: Lifecycle

  deinit {
    print("RootViewController deinit...")
  }

  // MARK: Internal

  weak var listener: RootPresentableListener?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
  }

}

// MARK: RootViewControllable

extension RootViewController: RootViewControllable {
  func present(viewController: ViewControllable) {
    let uiViewController = viewController.uiviewController
    uiViewController.isModalInPresentation = true
    uiViewController.modalPresentationStyle = .fullScreen
    present(uiViewController, animated: false)
  }

  func pushRootViewController(viewController: ViewControllable) {
    setViewControllers([viewController.uiviewController], animated: false)
  }

  func popRootViewController(viewController: ViewControllable) {
    setViewControllers([], animated: false)
  }

  func dismiss(viewController: ViewControllable) {
    guard presentedViewController === viewController.uiviewController else { return }
    dismiss(animated: false)
  }
}
