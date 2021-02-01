import RIBs
@testable import Application

// MARK: - LoginBuildableMock

class LoginBuildableMock: Builder<LoginDependency> {

  // MARK: Lifecycle

  init() {
    super.init(dependency: component)
  }

  // MARK: Private

  private let component = RootComponent(
    dependency: AppComponent(),
    rootViewController: RootViewController())

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
