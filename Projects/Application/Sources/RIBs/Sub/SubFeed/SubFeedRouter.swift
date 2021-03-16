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

  override init(interactor: SubFeedInteractable, viewController: SubFeedViewControllable) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  deinit {
    print("SubFeedRouter deinit...")
  }
}
