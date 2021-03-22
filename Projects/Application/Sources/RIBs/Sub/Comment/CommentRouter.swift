import RIBs

// MARK: - CommentInteractable

protocol CommentInteractable: Interactable {
  var router: CommentRouting? { get set }
  var listener: CommentListener? { get set }
}

// MARK: - CommentViewControllable

protocol CommentViewControllable: ViewControllable {
}

// MARK: - CommentRouter

final class CommentRouter: ViewableRouter<CommentInteractable, CommentViewControllable>, CommentRouting {

  override init(interactor: CommentInteractable, viewController: CommentViewControllable) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  deinit {
    print("CommentRouter deinit...")
  }
}
