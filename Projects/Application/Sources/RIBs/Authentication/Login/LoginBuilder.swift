import RIBs

// MARK: - LoginDependency

protocol LoginDependency: Dependency {}

// MARK: - LoginComponent

final class LoginComponent: Component<LoginDependency> {
  fileprivate var initialState: LoginDisplayModel.State {
    LoginDisplayModel.State.initialState()
  }
}

// MARK: - LoginBuildable

protocol LoginBuildable: Buildable {
  func build(withListener listener: LoginListener) -> LoginRouting
}

// MARK: - LoginBuilder

final class LoginBuilder: Builder<LoginDependency> {
  override init(dependency: LoginDependency) {
    super.init(dependency: dependency)
  }

  deinit {
    print("LoginBuilder deinit...")
  }
}

// MARK: LoginBuildable

extension LoginBuilder: LoginBuildable {
  func build(withListener listener: LoginListener) -> LoginRouting {
    let component = LoginComponent(dependency: dependency)
    let viewController = LoginViewController()
    let interactor = LoginInteractor(
      presenter: viewController,
      initialState: component.initialState)
    interactor.listener = listener
    return LoginRouter(interactor: interactor, viewController: viewController)
  }
}
