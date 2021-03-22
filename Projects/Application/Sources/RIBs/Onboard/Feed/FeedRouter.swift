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

  var navigatingRoutings = [String: ViewableRouting]()

  // MARK: Private

  private struct Const {
    static var commentID = "commentID"
  }

  private let commentBuilder: CommentBuildable

}

// MARK: FeedRouting, NavigatingViewableRouting

extension FeedRouter: FeedRouting, NavigatingViewableRouting {

  func routeToComment(item: FeedContentSectionModel.Cell) {
    let routing = commentBuilder.build(withListener: interactor, item: item)
    navigatingRoutings = push(router: routing, id: Const.commentID)
  }

  func routeToBackFromComment() {
    navigatingRoutings = pop(id: Const.commentID)
  }
}
