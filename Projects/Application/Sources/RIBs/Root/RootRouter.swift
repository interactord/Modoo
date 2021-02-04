import RIBs

// MARK: - RootInteractable

protocol RootInteractable: Interactable, AuthenticationListener, OnboardListener {
  var router: RootRouting? { get set }
  var listener: RootListener? { get set }
}

// MARK: - RootViewControllable

protocol RootViewControllable: ViewControllable {
  func present(viewController: ViewControllable)
  func dismiss(viewController: ViewControllable)
}

// MARK: - RootRouter

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable> {

  // MARK: Lifecycle

  init(
    interactor: RootInteractable,
    viewController: RootViewControllable,
    authenticationBuilder: AuthenticationBuildable,
    onboardBuilder: OnboardBuildable)
  {
    self.authenticationBuilder = authenticationBuilder
    self.onboardBuilder = onboardBuilder
    super.init(
      interactor: interactor,
      viewController: viewController)
    interactor.router = self
  }

  // MARK: Internal

  override func didLoad() {
    super.didLoad()
    routeToOnboard()
  }

  // MARK: Private

  private let authenticationBuilder: AuthenticationBuildable
  private let onboardBuilder: OnboardBuildable
  private weak var currentChild: ViewableRouting?

}

// MARK: RootRouting

extension RootRouter: RootRouting {
  func cleanupViews() {
    guard let currentChild = currentChild else { return }

    detachChild(currentChild)
    viewController.dismiss(viewController: currentChild.viewControllable)

    self.currentChild = nil
  }

  func routeToOnboard() {
    present(routing: onboardBuilder.build(withListener: interactor))
  }

  func routeToAuthentication() {
    present(routing: authenticationBuilder.build(withListener: interactor))
  }
}

extension RootRouter {

  private func present(routing: ViewableRouting) {
    cleanupViews()
    currentChild = routing
    attachChild(routing)

    viewController.present(viewController: routing.viewControllable)
  }

}
