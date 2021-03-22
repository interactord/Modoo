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

  // MARK: Internal

  var presentedRoutings = [ViewableRouting]()

  // MARK: Private

  private let commentBuilder: CommentBuildable
}

// MARK: FeedRouting, PresentingViewableRouting

extension FeedRouter: FeedRouting, PresentingViewableRouting {

  func routeToComment(item: FeedContentSectionModel.Cell) {
    let routing = commentBuilder.build(withListener: interactor)
    presentedRoutings = present(routings: presentedRoutings, routing: routing, showAnimated: true)
  }
}
