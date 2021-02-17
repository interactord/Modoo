import FirebaseAuth
import RIBs
import RxSwift
import UIKit

// MARK: - OnboardPresentableListener

protocol OnboardPresentableListener: AnyObject {
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

}

extension OnboardViewController {

  private func applyUIPreferences() {
    tabBar.tintColor = .black
  }
}

// MARK: OnboardViewControllable

extension OnboardViewController: OnboardViewControllable {

  func setVewControllers(viewControllers: [ViewControllable]) {
    setViewControllers(viewControllers.map { $0.uiviewController }, animated: false)
  }

}
