import RIBs
import UIKit

// MARK: - OnboardInteractable

protocol OnboardInteractable: Interactable, FeedListener, ProfileListener {
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
    feedBuilder: FeedBuildable,
    profileBuilder: ProfileBuildable)
  {
    defer { interactor.router = self }
    self.feedBuilder = feedBuilder
    self.profileBuilder = profileBuilder
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
  private let profileBuilder: ProfileBuildable

}

// MARK: OnboardRouting

extension OnboardRouter: OnboardRouting {

  // MARK: Internal

  func setOnceViewControllers() {
    viewController.setVewControllers(viewControllers: [
      applyFeedRouting(),
      applyProfileRouting(),
    ])
  }

  // MARK: Private

  private func applyFeedRouting() -> ViewControllable {
    let router = feedBuilder.build(withListener: interactor)
    attachChild(router)

    let navigationController = UINavigationController(
      image: #imageLiteral(resourceName: "feed-select"),
      unselectedImage: #imageLiteral(resourceName: "feed-normal"),
      root: router.viewControllable)
    navigationController.navigationBar.isHidden = true

    return navigationController
  }

  private func applyProfileRouting() -> ViewControllable {
    let router = profileBuilder.build(withListener: interactor)
    attachChild(router)

    let navigationController = UINavigationController(
      image: #imageLiteral(resourceName: "profile-select"),
      unselectedImage: #imageLiteral(resourceName: "profile-normal"),
      root: router.viewControllable)
    navigationController.navigationBar.isHidden = true

    return navigationController
  }

}
