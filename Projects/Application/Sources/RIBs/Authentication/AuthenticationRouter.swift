import UIKit

import RIBs

// MARK: - AuthenticationInteractable

protocol AuthenticationInteractable: Interactable, LoginListener {
  var router: AuthenticationRouting? { get set }
  var listener: AuthenticationListener? { get set }
}

// MARK: - AuthenticationViewControllable

protocol AuthenticationViewControllable: ViewControllable {
  func setRootViewController(viewController: ViewControllable)
  func clearChildViewControllers(with animated: Bool)
}

// MARK: - AuthenticationRouter

final class AuthenticationRouter: ViewableRouter<AuthenticationInteractable, AuthenticationViewControllable> {

  // MARK: Lifecycle

  init(
    interactor: AuthenticationInteractable,
    viewController: AuthenticationViewControllable,
    loginBuilder: LoginBuildable)
  {
    self.loginBuilder = loginBuilder

    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  // MARK: Internal

  override func didLoad() {
    super.didLoad()

    routeLogin()
  }

  // MARK: Private

  private let loginBuilder: LoginBuildable
  private var login: ViewableRouting?

}

// MARK: AuthenticationRouting

extension AuthenticationRouter: AuthenticationRouting {
  func cleanupViews() {
    viewController.clearChildViewControllers(with: false)
  }

  func routeLogin() {
    let login = loginBuilder.build(withListener: interactor)
    self.login = login

    attachChild(login)

    viewController.setRootViewController(viewController: login.viewControllable)
  }
}
