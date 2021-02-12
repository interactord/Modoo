import FirebaseAuth
import RIBs
import RxSwift
import UIKit

// MARK: - OnboardPresentableListener

protocol OnboardPresentableListener: AnyObject {
  func onLogout()
}

// MARK: - OnboardViewController

final class OnboardViewController: UITabBarController, OnboardPresentable {

  // MARK: Lifecycle

  deinit {
    print("OnboardViewController deinit...")
  }

  // MARK: Internal

  weak var listener: OnboardPresentableListener?

  override func viewDidLoad() {
    super.viewDidLoad()

    applyUIPreferences()
  }

  @objc
  func authenticationAction() {
    listener?.onLogout()
  }

}

extension OnboardViewController {

  private func applyUIPreferences() {
    tabBar.tintColor = .black

    // Todo: 이미버튼입니다. 나중에 내정보에 들어갈 기능입니다.
    let barButtonItem = UIBarButtonItem(
      title: "Logout",
      style: .plain,
      target: self,
      action: #selector(authenticationAction))
    navigationItem.rightBarButtonItem = barButtonItem
  }
}

// MARK: OnboardViewControllable

extension OnboardViewController: OnboardViewControllable {

  func setVewControllers(viewControllers: [ViewControllable]) {
    setViewControllers(viewControllers.map { $0.uiviewController }, animated: false)
  }

}
