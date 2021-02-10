import RIBs
@testable import Application

// MARK: - LoginBuildableMock

class LoginBuildableMock: Builder<LoginDependency> {

  // MARK: Lifecycle

  init() {
    super.init(dependency: LoginDependencyMock())
  }

  // MARK: Fileprivate

  fileprivate var authenticationUseCase: AuthenticationUseCase {
    FirebaseAuthenticationUseCase(
      authenticating: FirebaseAuthentication(),
      mediaUploading: FirebaseMediaUploader(),
      apiNetworking: FirebaseAPINetwork())
  }

}

// MARK: LoginBuildable

extension LoginBuildableMock: LoginBuildable {
  func build(withListener listener: LoginListener) -> LoginRouting {
    _ = LoginComponent(dependency: dependency)

    let viewController = LoginViewController()
    let interactor = LoginInteractor(
      presenter: viewController,
      initialState: LoginDisplayModel.State.initialState(),
      authenticationUseCase: authenticationUseCase)
    interactor.listener = listener
    return LoginRouter(interactor: interactor, viewController: viewController)
  }
}
