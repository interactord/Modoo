import FirebaseAuth
import ReactorKit
import RIBs
import RxOptional
import RxSwift
import UIKit

// MARK: - OnboardPresentableListener

protocol OnboardPresentableListener: AnyObject {
  var action: ActionSubject<OnboardDisplayModel.Action> { get }
  var state: Observable<OnboardDisplayModel.State> { get }
}

// MARK: - OnboardViewController

class OnboardViewController: UITabBarController, OnboardPresentable {

  // MARK: Lifecycle

  init(postMediaUseCase: PostMediaPickerUseCase) {
    self.postMediaUseCase = postMediaUseCase
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    print("OnboardViewController deinit...")
  }

  // MARK: Internal

  var postMediaUseCase: PostMediaPickerUseCase
  let disposeBag = DisposeBag()

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
      navigationController.viewControllerType == .post,
      let listener = self.listener else
    {
      return true
    }

    postMediaUseCase
      .load(viewController: self)
      .map { .postImage($0) }
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    return false
  }
}
