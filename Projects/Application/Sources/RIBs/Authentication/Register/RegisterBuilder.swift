import RIBs

// MARK: - RegisterDependency

protocol RegisterDependency: Dependency {
}

// MARK: - RegisterComponent

final class RegisterComponent: Component<RegisterDependency> {
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
    let viewController = RegisterViewController()
    let interactor = RegisterInteractor(
      presenter: viewController,
      initialState: .init())
    interactor.listener = listener
    return RegisterRouter(interactor: interactor, viewController: viewController)
  }
}
