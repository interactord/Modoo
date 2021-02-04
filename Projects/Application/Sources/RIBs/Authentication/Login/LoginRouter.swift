import RIBs

// MARK: - LoginInteractable

protocol LoginInteractable: Interactable {
  var router: LoginRouting? { get set }
  var listener: LoginListener? { get set }
}

// MARK: - LoginViewControllable

protocol LoginViewControllable: ViewControllable {}

// MARK: - LoginRouter

final class LoginRouter: ViewableRouter<LoginInteractable, LoginViewControllable>, LoginRouting {
  override init(interactor: LoginInteractable, viewController: LoginViewControllable)
  {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  deinit {
    print("LoginRouter deinit...")
  }
}
