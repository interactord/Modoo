import RIBs

// MARK: - AuthenticationInteractable

protocol AuthenticationInteractable: Interactable {
  var router: AuthenticationRouting? { get set }
  var listener: AuthenticationListener? { get set }
}

// MARK: - AuthenticationViewControllable

protocol AuthenticationViewControllable: ViewControllable {
}

// MARK: - AuthenticationRouter

final class AuthenticationRouter: ViewableRouter<AuthenticationInteractable, AuthenticationViewControllable>, AuthenticationRouting {

  override init(interactor: AuthenticationInteractable, viewController: AuthenticationViewControllable) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
}
