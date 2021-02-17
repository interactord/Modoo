import RIBs

// MARK: - RootInteractable

protocol RootInteractable: Interactable, AuthenticationListener, OnboardListener {
  var router: RootRouting? { get set }
  var listener: RootListener? { get set }
}

// MARK: - RootViewControllable

protocol RootViewControllable: ViewControllable {
  func present(viewControllable: ViewControllable, animated: Bool)
  func dismiss(viewControllable: ViewControllable, animated: Bool)
  func setRoot(viewControllable: ViewControllable, animated: Bool)
  func clearRootViewControllable(animated: Bool)
}

// MARK: - RootRouter

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable> {

  // MARK: Lifecycle

  init(
    interactor: RootInteractable,
    viewController: RootViewControllable,
    authenticationBuilder: AuthenticationBuildable,
    onboardBuilder: OnboardBuildable,
    authenticationUseCase: AuthenticationUseCase)
  {
    defer { interactor.router = self }
    self.authenticationBuilder = authenticationBuilder
    self.onboardBuilder = onboardBuilder
    self.authenticationUseCase = authenticationUseCase
    super.init(
      interactor: interactor,
      viewController: viewController)
  }

  // MARK: Internal

  override func didLoad() {
    super.didLoad()

    authenticationUseCase.authenticationToken.isEmpty
      ? routeToAuthentication()
      : routeToOnboard()
  }

  // MARK: Private

  private let authenticationBuilder: AuthenticationBuildable
  private let onboardBuilder: OnboardBuildable
  private weak var currentChild: ViewableRouting?
  private let authenticationUseCase: AuthenticationUseCase
}

// MARK: RootRouting

extension RootRouter: RootRouting {
  func cleanupViews() {
    guard let currentChild = currentChild else { return }

    detachChild(currentChild)
    viewController.dismiss(viewControllable: currentChild.viewControllable, animated: false)
    viewController.clearRootViewControllable(animated: false)

    self.currentChild = nil
  }

  func routeToOnboard() {
    guard !(currentChild is OnboardRouting) else { return }
    pushRoot(routing: onboardBuilder.build(withListener: interactor))
  }

  func routeToAuthentication() {
    authenticationUseCase.logout()
    guard !(currentChild is AuthenticationRouting) else { return }
    present(routing: authenticationBuilder.build(withListener: interactor))
  }
}

extension RootRouter {

  private func present(routing: ViewableRouting) {
    cleanupViews()
    currentChild = routing
    attachChild(routing)

    viewController.present(viewControllable: routing.viewControllable, animated: false)
  }

  private func pushRoot(routing: ViewableRouting) {
    cleanupViews()
    currentChild = routing
    attachChild(routing)

    viewController.setRoot(viewControllable: routing.viewControllable, animated: false)
  }

}
