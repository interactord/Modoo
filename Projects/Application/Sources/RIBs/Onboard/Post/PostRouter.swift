import RIBs

// MARK: - PostInteractable

protocol PostInteractable: Interactable {
  var router: PostRouting? { get set }
  var listener: PostListener? { get set }
}

// MARK: - PostViewControllable

protocol PostViewControllable: ViewControllable {
}

// MARK: - PostRouter

final class PostRouter: ViewableRouter<PostInteractable, PostViewControllable>, PostRouting {

  override init(interactor: PostInteractable, viewController: PostViewControllable) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  deinit {
    print("PostRouter deinit...")
  }
}
