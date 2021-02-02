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
    routerAuthentication()
  }

  func cleanupViews() {
    guard let currentChild = currentChild else { return }
    viewController.dismiss(viewController: currentChild.viewControllable)
    self.currentChild = nil
  }

  // MARK: Private

  private let authenticationBuilder: AuthenticationBuildable
  private var authentication: ViewableRouting?
  private let onboardBuilder: OnboardBuildable
  private var onboard: ViewableRouting?
  private var currentChild: ViewableRouting?

}

// MARK: RootRouting

extension RootRouter: RootRouting {
  func routeToLoggedIn() {
    routeOnboard()
  }
}

// MARK: - Inner Method

extension RootRouter {
  fileprivate func routerAuthentication() {
    cleanupViews()

    let authentication = authenticationBuilder.build(withListener: interactor)
    self.authentication = authentication
    currentChild = authentication

    attachChild(authentication)

    viewController.present(viewController: authentication.viewControllable)
  }

  fileprivate func routeOnboard() {
    cleanupViews()

    let onboard = onboardBuilder.build(withListener: interactor)
    self.onboard = onboard
    currentChild = onboard

    attachChild(onboard)

    viewController.present(viewController: onboard.viewControllable)
  }
}
