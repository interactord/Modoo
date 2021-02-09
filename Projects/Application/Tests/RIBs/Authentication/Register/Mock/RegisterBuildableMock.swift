import RIBs

@testable import Application

// MARK: - RegisterBuildableMock

class RegisterBuildableMock: Builder<RegisterDependency> {

  init() {
    super.init(dependency: RegisterDependencyMock())
  }
}

// MARK: RegisterBuildable

extension RegisterBuildableMock: RegisterBuildable {
  func build(withListener listener: RegisterListener) -> RegisterRouting {
    _ = RegisterComponent(dependency: dependency)

    let viewController = RegisterViewController(mediaPickerUseCase: UIMediaPickerPlatformUseCase())
    let interactor = RegisterInteractor(
      presenter: viewController,
      initialState: RegisterDisplayModel.State.initialState())
    interactor.listener = listener
    return RegisterRouter(interactor: interactor, viewController: viewController)
  }
}
