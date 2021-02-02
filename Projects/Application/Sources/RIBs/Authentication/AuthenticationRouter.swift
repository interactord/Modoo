import UIKit

import RIBs

// MARK: - AuthenticationInteractable

protocol AuthenticationInteractable: Interactable, LoginListener, RegisterListener {
  var router: AuthenticationRouting? { get set }
  var listener: AuthenticationListener? { get set }
}

// MARK: - AuthenticationViewControllable

protocol AuthenticationViewControllable: ViewControllable {
  func setRootViewController(viewController: ViewControllable)
  func clearChildViewControllers(with animated: Bool)
  func pushViewController(viewController: ViewControllable, with animated: Bool)
}

// MARK: - AuthenticationRouter

final class AuthenticationRouter: ViewableRouter<AuthenticationInteractable, AuthenticationViewControllable> {

  // MARK: Lifecycle

  init(
    interactor: AuthenticationInteractable,
    viewController: AuthenticationViewControllable,
    loginBuilder: LoginBuildable,
    registerBuilder: RegisterBuildable)
  {
    self.loginBuilder = loginBuilder
    self.registerBuilder = registerBuilder

    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  // MARK: Internal

  override func didLoad() {
    super.didLoad()

    routeToLogin()
  }

  // MARK: Private

  private let loginBuilder: LoginBuildable
  private var login: ViewableRouting?
  private let registerBuilder: RegisterBuildable
  private var register: ViewableRouting?

}

// MARK: AuthenticationRouting

extension AuthenticationRouter: AuthenticationRouting {

  // MARK: Internal

  func cleanupViews() {
    viewController.clearChildViewControllers(with: false)
  }

  func routeToLogin() {
    let login = loginBuilder.build(withListener: interactor)
    self.login = login

    attachChild(login)

    viewController.setRootViewController(viewController: login.viewControllable)
  }

  func routeToRegister() {
    let register = getRegister()
    viewController.pushViewController(viewController: register.viewControllable, with: true)
  }

  // MARK: Private

  private func getRegister() -> ViewableRouting {
    if let register = register { return register }

    let register = registerBuilder.build(withListener: interactor)
    self.register = register
    attachChild(register)

    return register
  }

}
