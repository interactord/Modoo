import RIBs

// MARK: - RegisterDependency

protocol RegisterDependency: Dependency {
}

// MARK: - RegisterComponent

final class RegisterComponent: Component<RegisterDependency> {

  fileprivate var mediaPickerUseCase: MediaPickerUseCase {
    UIMediaPickerPlatformUseCase()
  }

  fileprivate var authenticationUseCase: AuthenticationUseCase {
    FirebaseAuthenticationUseCase(
      authenticating: FirebaseAuthentication(),
      uploading: FirebaseMediaUploader(),
      apiNetworking: FirebaseAPINetwork())
  }

  fileprivate var initialState: RegisterDisplayModel.State {
    RegisterDisplayModel.State.initialState()
  }

}

// MARK: - RegisterBuildable

protocol RegisterBuildable: Buildable {
  func build(withListener listener: RegisterListener) -> RegisterRouting
}

// MARK: - RegisterBuilder

final class RegisterBuilder: Builder<RegisterDependency> {

  override init(dependency: RegisterDependency) {
    super.init(dependency: dependency)
  }

  deinit {
    print("RegisterBuilder deinit...")
  }
}

// MARK: RegisterBuildable

extension RegisterBuilder: RegisterBuildable {
  func build(withListener listener: RegisterListener) -> RegisterRouting {
    let component = RegisterComponent(dependency: dependency)
    let viewController = RegisterViewController(mediaPickerUseCase: component.mediaPickerUseCase)
    let interactor = RegisterInteractor(
      presenter: viewController,
      initialState: component.initialState,
      authenticationUseCase: component.authenticationUseCase)
    interactor.listener = listener
    return RegisterRouter(interactor: interactor, viewController: viewController)
  }
}
