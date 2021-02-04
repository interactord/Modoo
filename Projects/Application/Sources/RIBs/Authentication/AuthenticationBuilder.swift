import RIBs

// MARK: - AuthenticationDependency

protocol AuthenticationDependency: Dependency {
}

// MARK: - AuthenticationComponent

final class AuthenticationComponent: Component<AuthenticationDependency> {
}

// MARK: AuthenticationDependency

extension AuthenticationComponent: AuthenticationDependency {
}

// MARK: LoginDependency

extension AuthenticationComponent: LoginDependency {
}

// MARK: RegisterDependency

extension AuthenticationComponent: RegisterDependency {
}

// MARK: - AuthenticationBuildable

protocol AuthenticationBuildable: Buildable {
  func build(withListener listener: AuthenticationListener) -> AuthenticationRouting
}

// MARK: - AuthenticationBuilder

final class AuthenticationBuilder: Builder<AuthenticationDependency>, AuthenticationBuildable {

  // MARK: Lifecycle

  override init(dependency: AuthenticationDependency) {
    super.init(dependency: dependency)
  }

  deinit {
    print("AuthenticationBuilder deinit")
  }

  // MARK: Internal

  func build(withListener listener: AuthenticationListener) -> AuthenticationRouting {
    let viewController = AuthenticationViewController()
    let interactor = AuthenticationInteractor(presenter: viewController)
    interactor.listener = listener

    let component = AuthenticationComponent(dependency: dependency)
    let loginBuilderType: LoginBuilderAdapter.Type = BuilderContainer.resolve(for: LoginBuilderBuilderID)
    let registerBuilderType: RegisterBuilderAdapter.Type = BuilderContainer.resolve(for: RegisterBuilderID)

    return AuthenticationRouter(
      interactor: interactor,
      viewController: viewController,
      loginBuilder: loginBuilderType.init(dependency: component),
      registerBuilder: registerBuilderType.init(dependency: component))
  }

}
