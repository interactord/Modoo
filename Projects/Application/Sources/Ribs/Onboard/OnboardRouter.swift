import RIBs

protocol OnboardInteractable: Interactable {
  var router: OnboardRouting? { get set }
  var listener: OnboardListener? { get set }
}

protocol OnboardViewControllable: ViewControllable {
}

final class OnboardRouter: ViewableRouter<OnboardInteractable, OnboardViewControllable>, OnboardRouting {
  override init(interactor: OnboardInteractable,
                viewController: OnboardViewControllable) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
}
