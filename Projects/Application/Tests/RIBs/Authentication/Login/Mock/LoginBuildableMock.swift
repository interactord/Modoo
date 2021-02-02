import RIBs
@testable import Application

// MARK: - LoginBuildableMock

class LoginBuildableMock: Builder<LoginDependency> {

  init() {
    super.init(dependency: LoginDependencyMock())
  }

}

// MARK: LoginBuildable

extension LoginBuildableMock: LoginBuildable {
  func build(withListener listener: LoginListener) -> LoginRouting {
    _ = LoginComponent(dependency: dependency)

    let viewController = LoginViewController()
    let interactor = LoginInteractor(presenter: viewController)
    interactor.listener = listener
    return LoginRouter(interactor: interactor, viewController: viewController)
  }
}
