import RIBs

// MARK: - FeedInteractable

protocol FeedInteractable: Interactable {
  var router: FeedRouting? { get set }
  var listener: FeedListener? { get set }
}

// MARK: - FeedViewControllable

protocol FeedViewControllable: ViewControllable {
}

// MARK: - FeedRouter

final class FeedRouter: ViewableRouter<FeedInteractable, FeedViewControllable> {

  override init(interactor: FeedInteractable, viewController: FeedViewControllable) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  deinit {
    print("FeedRouter deinit...")
  }
}

// MARK: FeedRouting

extension FeedRouter: FeedRouting {
}
