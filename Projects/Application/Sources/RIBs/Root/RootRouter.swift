import RIBs

// MARK: - RootInteractable

protocol RootInteractable: Interactable, LoginListener, OnboardListener {
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
    loginBuilder: LoginBuildable,
    onboardBuilder: OnboardBuildable)
  {
    self.loginBuilder = loginBuilder
    self.onboardBuilder = onboardBuilder
    super.init(
      interactor: interactor,
      viewController: viewController)
    interactor.router = self
  }

  // MARK: Internal

  override func didLoad() {
    super.didLoad()
    routeLogin()
  }

  func cleanupViews() {
    guard let currentChild = currentChild else { return }

    viewController.dismiss(viewController: currentChild.viewControllable)
    self.currentChild = nil
  }

  // MARK: Private

  private let loginBuilder: LoginBuildable
  private var login: ViewableRouting?
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
  fileprivate func routeLogin() {
    cleanupViews()

    let login = loginBuilder.build(withListener: interactor)
    self.login = login
    currentChild = login

    attachChild(login)

    viewController.present(viewController: login.viewControllable)
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
