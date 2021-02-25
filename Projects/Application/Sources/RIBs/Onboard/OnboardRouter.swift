import RIBs
import UIKit

// MARK: - OnboardInteractable

protocol OnboardInteractable: Interactable, FeedListener, SearchListener, ProfileListener, PostListener {
  var router: OnboardRouting? { get set }
  var listener: OnboardListener? { get set }
}

// MARK: - OnboardViewControllable

protocol OnboardViewControllable: ViewControllable, UIViewControllerViewable {
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
    searchBuilder: SearchBuildable,
    postBuilder: PostBuildable)
  {
    defer { interactor.router = self }
    self.feedBuilder = feedBuilder
    self.profileBuilder = profileBuilder
    self.searchBuilder = searchBuilder
    self.postBuilder = postBuilder
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
  private let postBuilder: PostBuildable
  private var postRouting: ViewableRouting?

}

// MARK: OnboardRouting

extension OnboardRouter: OnboardRouting {

  // MARK: Internal

  func setOnceViewControllers() {
    viewController.setVewControllers(viewControllers: [
      applyFeedRouting(),
      applySearchRouting(),
      makePeedViewController(),
      applyProfileRouting(),
    ])
  }

  func routeToPost() {
    if let postRouting = postRouting {
      detachChild(postRouting)
      self.postRouting = nil
    }

    let postRouting = postBuilder.build(withListener: interactor)
    attachChild(postRouting)
    self.postRouting = postRouting
    viewController.present(
      viewControllable: postRouting.viewControllable,
      isFullScreenSize: true,
      animated: true)
  }

  // MARK: Private

  private func applyFeedRouting() -> ViewControllable {
    makeNavigationRouting(
      image: #imageLiteral(resourceName: "feed-select"),
      unselctedImage: #imageLiteral(resourceName: "feed-normal"),
      router: feedBuilder.build(withListener: interactor),
      viewControllerType: .feed)
  }

  private func applyProfileRouting() -> ViewControllable {
    makeNavigationRouting(
      image: #imageLiteral(resourceName: "profile-select"),
      unselctedImage: #imageLiteral(resourceName: "profile-normal"),
      router: profileBuilder.build(withListener: interactor),
      viewControllerType: .profile)
  }

  private func applySearchRouting() -> ViewControllable {
    makeNavigationRouting(
      image: #imageLiteral(resourceName: "search-select"),
      unselctedImage: #imageLiteral(resourceName: "search-normal"),
      router: searchBuilder.build(withListener: interactor),
      viewControllerType: .search)
  }

  private func makeNavigationRouting(image: UIImage, unselctedImage: UIImage, router: ViewableRouting, viewControllerType: NavigationController.ViewControllerType) -> ViewControllable {
    attachChild(router)

    let navigationController = NavigationController(
      viewControllerType: viewControllerType,
      image: image,
      unselectedImage: unselctedImage,
      root: router.viewControllable)
    navigationController.navigationBar.isHidden = true

    return navigationController
  }

  private func makePeedViewController() -> ViewControllable {
    let navigationController = NavigationController(
      viewControllerType: .post,
      image: #imageLiteral(resourceName: "photo"),
      unselectedImage: #imageLiteral(resourceName: "photo"),
      root: EmptyViewController())
    navigationController.navigationBar.isHidden = true

    return navigationController
  }

}
