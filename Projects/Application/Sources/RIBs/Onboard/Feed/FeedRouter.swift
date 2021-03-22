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

  // MARK: Lifecycle

  init(
    interactor: FeedInteractable,
    viewController: FeedViewControllable,
    commentBuilder: CommentBuildable)
  {
    defer { interactor.router = self }
    self.commentBuilder = commentBuilder
    super.init(interactor: interactor, viewController: viewController)
  }

  deinit {
    print("FeedRouter deinit...")
  }

  // MARK: Private

  private let commentBuilder: CommentBuildable
}

// MARK: FeedRouting

extension FeedRouter: FeedRouting {
}
