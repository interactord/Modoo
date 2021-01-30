import RIBs

protocol LoginDependency: Dependency {}

final class LoginComponent: Component<LoginDependency> {}

// MARK: - Builder

protocol LoginBuildable: Buildable {
  func build(withListener listener: LoginListener) -> LoginRouting
}

final class LoginBuilder: Builder<LoginDependency> {
  override init(dependency: LoginDependency) {
    super.init(dependency: dependency)
  }
}

// MARK: LoginBuildable

extension LoginBuilder: LoginBuildable {
  func build(withListener listener: LoginListener) -> LoginRouting {
    _ = LoginComponent(dependency: dependency)

    let viewController = LoginViewController()
    let interactor = LoginInteractor(presenter: viewController)
    interactor.listener = listener
    return LoginRouter(interactor: interactor, viewController: viewController)
  }
}
