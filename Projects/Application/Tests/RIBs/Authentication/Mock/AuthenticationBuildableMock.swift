import RIBs
@testable import Application

// MARK: - AuthenticationBuildableMock

class AuthenticationBuildableMock: Builder<AuthenticationDependency> {

  override init(dependency: AuthenticationDependency) {
    super.init(dependency: dependency)
  }

}

// MARK: AuthenticationBuildable

extension AuthenticationBuildableMock: AuthenticationBuildable {
  func build(withListener listener: AuthenticationListener) -> AuthenticationRouting {
    _ = AuthenticationComponent(dependency: dependency)
    let viewController = AuthenticationViewController()
    let interactor = AuthenticationInteractor(presenter: viewController)
    interactor.listener = listener

    return AuthenticationRouter(interactor: interactor, viewController: viewController)
  }
}
