import UIKit

import RIBs
import RxSwift

// MARK: - AuthenticationPresentableListener

protocol AuthenticationPresentableListener: AnyObject {
}

// MARK: - AuthenticationViewController

final class AuthenticationViewController: UINavigationController, AuthenticationPresentable {

  weak var listener: AuthenticationPresentableListener?

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    applyUIPreferences()
  }
}

extension AuthenticationViewController {
  fileprivate func applyUIPreferences() {
    navigationBar.isHidden = true
    navigationBar.barStyle  = .black
  }
}

// MARK: AuthenticationViewControllable

extension AuthenticationViewController: AuthenticationViewControllable {

  func clearChildViewControllers() {
    setViewControllers([], animated: false)
  }

  func setRootViewController(viewController: ViewControllable) {
    setViewControllers([viewController.uiviewController], animated: false)
  }

  func pushViewController(viewController: ViewControllable) {
    pushViewController(viewController.uiviewController, animated: true)
  }

  func popToRootViewController() {
    popToRootViewController(animated: true)
  }

}
