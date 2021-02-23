import RIBs

// MARK: - SubProfileInteractable

protocol SubProfileInteractable: Interactable {
  var router: SubProfileRouting? { get set }
  var listener: SubProfileListener? { get set }
}

// MARK: - SubProfileViewControllable

protocol SubProfileViewControllable: ViewControllable {
}

// MARK: - SubProfileRouter

final class SubProfileRouter: ViewableRouter<SubProfileInteractable, SubProfileViewControllable>, SubProfileRouting {

  override init(interactor: SubProfileInteractable, viewController: SubProfileViewControllable) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  deinit {
    print("SubProfileRouter deinit...")
  }
}
