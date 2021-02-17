import RIBs
import UIKit

// MARK: - OnboardInteractable

protocol OnboardInteractable: Interactable, FeedListener, SearchListener, ProfileListener {
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
    profileBuilder: ProfileBuildable,
    searchBuilder: SearchBuildable)
  {
    defer { interactor.router = self }
    self.feedBuilder = feedBuilder
    self.profileBuilder = profileBuilder
    self.searchBuilder = searchBuilder
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
  private let searchBuilder: SearchBuildable

}

// MARK: OnboardRouting

extension OnboardRouter: OnboardRouting {

  // MARK: Internal

  func setOnceViewControllers() {
    viewController.setVewControllers(viewControllers: [
      applyFeedRouting(),
      applySearchRouting(),
      applyProfileRouting(),
    ])
  }

  // MARK: Private

  private func applyFeedRouting() -> ViewControllable {
    makeNavigationRouting(
      image: #imageLiteral(resourceName: "feed-select"),
      unselctedImage: #imageLiteral(resourceName: "feed-normal"),
      router: feedBuilder.build(withListener: interactor))
  }

  private func applyProfileRouting() -> ViewControllable {
    makeNavigationRouting(
      image: #imageLiteral(resourceName: "profile-select"),
      unselctedImage: #imageLiteral(resourceName: "profile-normal"),
      router: profileBuilder.build(withListener: interactor))
  }

  private func applySearchRouting() -> ViewControllable {
    makeNavigationRouting(
      image: #imageLiteral(resourceName: "search-select"),
      unselctedImage: #imageLiteral(resourceName: "search-normal"),
      router: searchBuilder.build(withListener: interactor))
  }

  private func makeNavigationRouting(image: UIImage, unselctedImage: UIImage, router: ViewableRouting) -> ViewControllable {
    attachChild(router)

    let navigationController = UINavigationController(
      image: image,
      unselectedImage: unselctedImage,
      root: router.viewControllable)
    navigationController.navigationBar.isHidden = true

    return navigationController
  }

}
