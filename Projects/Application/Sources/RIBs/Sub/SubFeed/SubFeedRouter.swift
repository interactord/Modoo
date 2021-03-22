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

  override init(interactor: SubFeedInteractable, viewController: SubFeedViewControllable){
    defer { interactor.router = self }
    super.init(interactor: interactor, viewController: viewController)
  }

  deinit {
    print("SubFeedRouter deinit...")
  }
}

// MARK: SubFeedRouting

extension SubFeedRouter: SubFeedRouting {
}
