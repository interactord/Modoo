import RIBs

@testable import Application

// MARK: - RegisterBuildableMock

class RegisterBuildableMock: Builder<RegisterDependency> {

  // MARK: Lifecycle

  init() {
    super.init(dependency: RegisterDependencyMock())
  }

  // MARK: Fileprivate

  fileprivate var authenticationUseCase: AuthenticationUseCase {
    FirebaseAuthenticationUseCase(
      authenticating: FirebaseAuthentication(),
      uploading: FirebaseMediaUploader(),
      apiNetworking: FirebaseAPINetwork())
  }
}

// MARK: RegisterBuildable

extension RegisterBuildableMock: RegisterBuildable {
  func build(withListener listener: RegisterListener) -> RegisterRouting {
    _ = RegisterComponent(dependency: dependency)

    let viewController = RegisterViewController(mediaPickerUseCase: UIMediaPickerPlatformUseCase())

    let interactor = RegisterInteractor(
      presenter: viewController,
      initialState: RegisterDisplayModel.State.initialState(),
      authenticationUseCase: authenticationUseCase)
    interactor.listener = listener
    return RegisterRouter(interactor: interactor, viewController: viewController)
  }
}
