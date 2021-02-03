import RIBs

// MARK: - RegisterInteractable

protocol RegisterInteractable: Interactable {
  var router: RegisterRouting? { get set }
  var listener: RegisterListener? { get set }
}

// MARK: - RegisterViewControllable

protocol RegisterViewControllable: ViewControllable {
}

// MARK: - RegisterRouter

final class RegisterRouter: ViewableRouter<RegisterInteractable, RegisterViewControllable> {

  override init(interactor: RegisterInteractable, viewController: RegisterViewControllable) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
}

// MARK: RegisterRouting

extension RegisterRouter: RegisterRouting {}
