import RIBs
import UIKit

// MARK: - OnboardInteractable

protocol OnboardInteractable: Interactable, FeedListener {
  var router: OnboardRouting? { get set }
  var listener: OnboardListener? { get set }
}

// MARK: - OnboardViewControllable

protocol OnboardViewControllable: ViewControllable {
  func setVewControllers(viewControllers: [ViewControllable])
}

// MARK: - OnboardTabBarContentType

enum OnboardTabBarContentType {
  case feed
}

// MARK: - OnboardRouter

final class OnboardRouter: ViewableRouter<OnboardInteractable, OnboardViewControllable> {

  // MARK: Lifecycle

  init(
    interactor: OnboardInteractable,
    viewController: OnboardViewControllable,
    feedBuilder: FeedBuildable)
  {
    defer { interactor.router = self }
    self.feedBuilder = feedBuilder
    super.init(interactor: interactor, viewController: viewController)
  }

  // MARK: Internal

  enum TabBarType {
    case feed
  }

  override func didLoad() {
    super.didLoad()

    setOnceViewControllers()
  }

  // MARK: Private

  private let feedBuilder: FeedBuildable

}

// MARK: OnboardRouting

extension OnboardRouter: OnboardRouting {

  func setOnceViewControllers() {
    viewController.setVewControllers(viewControllers: [
      applyFeedRouting(),
    ])
  }

  func applyFeedRouting() -> ViewControllable {
    let router = feedBuilder.build(withListener: interactor)
    attachChild(router)

    let navigationController = UINavigationController(
      image: #imageLiteral(resourceName: "feed-select"),
      unselectedImage: #imageLiteral(resourceName: "feed-normal"),
      root: router.viewControllable)
    navigationController.navigationBar.isHidden = true

    return navigationController
  }

}
