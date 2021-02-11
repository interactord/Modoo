import RIBs

// MARK: - OnboardInteractable

protocol OnboardInteractable: Interactable {
  var router: OnboardRouting? { get set }
  var listener: OnboardListener? { get set }
}

// MARK: - OnboardViewControllable

protocol OnboardViewControllable: ViewControllable {
  func applyVewControllers(viewControllers: [ViewControllable])
}

// MARK: - OnboardRouter

final class OnboardRouter: ViewableRouter<OnboardInteractable, OnboardViewControllable> {
  override init(
    interactor: OnboardInteractable,
    viewController: OnboardViewControllable)
  {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

}

// MARK: OnboardRouting

extension OnboardRouter: OnboardRouting {

  func setViewControllers() {
    viewController.applyVewControllers(viewControllers: [])
  }
}
