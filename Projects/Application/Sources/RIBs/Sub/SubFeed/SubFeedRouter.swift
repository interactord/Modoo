import RIBs

// MARK: - SubFeedInteractable

protocol SubFeedInteractable: Interactable {
  var router: SubFeedRouting? { get set }
  var listener: SubFeedListener? { get set }
}

// MARK: - SubFeedViewControllable

protocol SubFeedViewControllable: ViewControllable {
}

// MARK: - SubFeedRouter

final class SubFeedRouter: ViewableRouter<SubFeedInteractable, SubFeedViewControllable>, SubFeedRouting {

  // MARK: Lifecycle

  init(
    interactor: SubFeedInteractable,
    viewController: SubFeedViewControllable,
    commentBuilder: CommentBuildable)
  {
    defer { interactor.router = self }
    self.commentBuilder = commentBuilder
    super.init(interactor: interactor, viewController: viewController)
  }

  deinit {
    print("SubFeedRouter deinit...")
  }

  // MARK: Private

  private let commentBuilder: CommentBuildable
}
