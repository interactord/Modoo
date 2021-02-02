import RIBs

// MARK: - RegisterInteractable

protocol RegisterInteractable: Interactable {
  var router: RegisterRouting? { get set }
  var listener: RegisterListener? { get set }
}

// MARK: - RegisterViewControllable

protocol RegisterViewControllable: ViewControllable {
  // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

// MARK: - RegisterRouter

final class RegisterRouter: ViewableRouter<RegisterInteractable, RegisterViewControllable> {

  // TODO: Constructor inject child builder protocols to allow building children.
  override init(interactor: RegisterInteractable, viewController: RegisterViewControllable) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
}

// MARK: RegisterRouting

extension RegisterRouter: RegisterRouting {

}
