import RIBs

// MARK: - SubFeedInteractable

protocol SubFeedInteractable: Interactable, CommentListener {
  var router: SubFeedRouting? { get set }
  var listener: SubFeedListener? { get set }
}

// MARK: - SubFeedViewControllable

protocol SubFeedViewControllable: ViewControllable, UIViewControllerViewable {
}

// MARK: - SubFeedRouter

final class SubFeedRouter: ViewableRouter<SubFeedInteractable, SubFeedViewControllable> {

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

  // MARK: Internal

  var presentedRoutings = [ViewableRouting]()

  // MARK: Private

  private let commentBuilder: CommentBuildable
}

// MARK: SubFeedRouting, PresentingViewableRouting

extension SubFeedRouter: SubFeedRouting, PresentingViewableRouting {

  func routeToComment(item: FeedContentSectionModel.Cell) {
    let routing = commentBuilder.build(withListener: interactor)
    presentedRoutings = present(routings: presentedRoutings, routing: routing, showAnimated: true)
  }
}
