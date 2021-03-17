import RIBs
import UIKit

// MARK: - OnboardInteractable

protocol OnboardInteractable: Interactable, FeedListener, SearchListener, ProfileListener, PostListener, SubFeedListener {
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
    postBuilder: PostBuildable,
    subFeedBuilder: SubFeedBuildable)
  {
    defer { interactor.router = self }
    self.feedBuilder = feedBuilder
    self.profileBuilder = profileBuilder
    self.searchBuilder = searchBuilder
    self.postBuilder = postBuilder
    self.subFeedBuilder = subFeedBuilder
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
  private var presentedRoutings = [ViewableRouting]()
  private var subFeedBuilder: SubFeedBuildable

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

  func routeToPost(image: UIImage) {
    presentRouting(routing: postBuilder.build(withListener: interactor, image: image), showAnimated: false)
  }

  func routeToClose() {
    clearPresentRouting(animated: true)
  }

  func routeToSubFeed() {
    presentRouting(routing: subFeedBuilder.build(withListener: interactor), showAnimated: true)
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
      image: #imageLiteral(resourceName: "create-post-icon"),
      unselectedImage: #imageLiteral(resourceName: "create-post-icon"),
      root: EmptyViewController())
    navigationController.navigationBar.isHidden = true

    return navigationController
  }

  private func clearPresentRouting(animated: Bool) {
    presentedRoutings.forEach{ detachChild($0) }

    viewController.dismiss(viewControllable: viewController, animated: true)
  }

  private func presentRouting(routing: ViewableRouting, showAnimated: Bool) {
    clearPresentRouting(animated: false)
    presentedRoutings.append(routing)
    viewController.present(
      viewControllable: routing.viewControllable,
      isFullScreenSize: true,
      animated: showAnimated)
  }
}
