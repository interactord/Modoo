import RIBs
import RxSwift
import UIKit

// MARK: - RootPresentableListener

protocol RootPresentableListener: AnyObject {
  func didLogin()
}

// MARK: - RootViewController

final class RootViewController: UIViewController, RootPresentable {
  weak var listener: RootPresentableListener?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red
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

  func dismiss(viewController: ViewControllable) {
    guard presentedViewController === viewController.uiviewController else { return }
    dismiss(animated: false)
  }
}
