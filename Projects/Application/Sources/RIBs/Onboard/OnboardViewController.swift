import FirebaseAuth
import RIBs
import RxSwift
import UIKit

// MARK: - OnboardPresentableListener

protocol OnboardPresentableListener: AnyObject {
  func routeToPost()
}

// MARK: - OnboardViewController

class OnboardViewController: UITabBarController, OnboardPresentable {

  // MARK: Lifecycle

  deinit {
    print("OnboardViewController deinit...")
  }

  // MARK: Internal

  weak var listener: OnboardPresentableListener?

  override func loadView() {
    super.loadView()

    delegate = self
  }

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

// MARK: UITabBarControllerDelegate

extension OnboardViewController: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    guard
      let navigationController = viewController as? NavigationController,
      navigationController.viewControllerType == .post else
    {
      return true
    }

    listener?.routeToPost()
    return false
  }
}
