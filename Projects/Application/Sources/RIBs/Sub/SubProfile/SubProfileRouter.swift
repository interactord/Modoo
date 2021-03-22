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

final class SubProfileRouter: ViewableRouter<SubProfileInteractable, SubProfileViewControllable>{

  override init(interactor: SubProfileInteractable, viewController: SubProfileViewControllable){
    defer { interactor.router = self }
    super.init(interactor: interactor, viewController: viewController)
  }

  deinit {
    print("SubProfileRouter deinit...")
  }
}

// MARK: SubProfileRouting

extension SubProfileRouter: SubProfileRouting {
}
