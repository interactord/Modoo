import RIBs

// MARK: - FeedInteractable

protocol FeedInteractable: Interactable, CommentListener {
  var router: FeedRouting? { get set }
  var listener: FeedListener? { get set }
}

// MARK: - FeedViewControllable

protocol FeedViewControllable: ViewControllable, UIViewControllerViewable {
}

// MARK: - FeedRouter

final class FeedRouter: ViewableRouter<FeedInteractable, FeedViewControllable> {

  override init(
    interactor: FeedInteractable,
    viewController: FeedViewControllable)
  {
    defer { interactor.router = self }
    super.init(interactor: interactor, viewController: viewController)
  }

  deinit {
    print("FeedRouter deinit...")
  }

}

// MARK: FeedRouting

extension FeedRouter: FeedRouting {
}
