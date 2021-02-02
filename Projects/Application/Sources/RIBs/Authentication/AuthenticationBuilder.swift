import RIBs

// MARK: - AuthenticationDependency

protocol AuthenticationDependency: Dependency {
}

// MARK: - AuthenticationComponent

final class AuthenticationComponent: Component<AuthenticationDependency> {
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

  // MARK: Internal

  func build(withListener listener: AuthenticationListener) -> AuthenticationRouting {
    _ = AuthenticationComponent(dependency: dependency)
    let viewController = AuthenticationViewController()
    let interactor = AuthenticationInteractor(presenter: viewController)
    interactor.listener = listener

    return AuthenticationRouter(interactor: interactor, viewController: viewController)
  }
}
