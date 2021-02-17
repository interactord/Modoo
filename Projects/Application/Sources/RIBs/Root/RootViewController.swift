import RIBs
import RxSwift
import UIKit

// MARK: - RootPresentableListener

protocol RootPresentableListener: AnyObject {
}

// MARK: - RootViewController

class RootViewController: UINavigationController, RootPresentable {

  // MARK: Lifecycle

  deinit {
    print("RootViewController deinit...")
  }

  // MARK: Internal

  weak var listener: RootPresentableListener?

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationBar.isHidden = true
    view.backgroundColor = .white
  }

}

// MARK: RootViewControllable

extension RootViewController: RootViewControllable {
  func present(viewControllable: ViewControllable, animated: Bool) {
    let uiViewController = viewControllable.uiviewController
    uiViewController.isModalInPresentation = true
    uiViewController.modalPresentationStyle = .fullScreen
    present(uiViewController, animated: animated)
  }

  func setRoot(viewControllable: ViewControllable, animated: Bool) {
    setViewControllers([viewControllable.uiviewController], animated: false)
  }

  func clearRootViewControllable(animated: Bool) {
    setViewControllers([], animated: animated)
  }

  func dismiss(viewControllable: ViewControllable, animated: Bool) {
    guard presentedViewController === viewControllable.uiviewController else { return }
    dismiss(animated: animated)
  }
}
