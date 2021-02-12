import RIBs

// MARK: - OnboardInteractable

protocol OnboardInteractable: Interactable, FeedListener {
  var router: OnboardRouting? { get set }
  var listener: OnboardListener? { get set }
}

// MARK: - OnboardViewControllable

protocol OnboardViewControllable: ViewControllable {
  func applyVewControllers(viewControllers: [ViewControllable])
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
    guard children.isEmpty else { return }

    viewController.applyVewControllers(viewControllers: [
      applyFeedRouting(),
    ])
  }

  func applyFeedRouting() -> ViewControllable {
    let routing = feedBuilder.build(withListener: interactor)
    attachChild(routing)
    return routing.viewControllable
  }

}
