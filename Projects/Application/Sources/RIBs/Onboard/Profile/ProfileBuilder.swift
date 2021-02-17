import RIBs

// MARK: - ProfileDependency

protocol ProfileDependency: Dependency {
}

// MARK: - ProfileComponent

final class ProfileComponent: Component<ProfileDependency> {
  fileprivate var initailState: ProfileDisplayModel.State { .initialState() }
  fileprivate var userUseCase: UserUseCase {
    FirebaseUserUseCase(
      authenticating: FirebaseAuthentication(),
      apiNetworking: FirebaseAPINetwork())
  }
}

// MARK: - ProfileBuildable

protocol ProfileBuildable: Buildable {
  func build(withListener listener: ProfileListener) -> ProfileRouting
}

// MARK: - ProfileBuilder

final class ProfileBuilder: Builder<ProfileDependency>, ProfileBuildable {

  // MARK: Lifecycle

  override init(dependency: ProfileDependency) {
    super.init(dependency: dependency)
  }

  deinit {
    print("ProfileBuilder deinit...")
  }

  // MARK: Internal

  func build(withListener listener: ProfileListener) -> ProfileRouting {
    let component = ProfileComponent(dependency: dependency)
    let viewController = ProfileViewController(node: .init())
    let interactor = ProfileInteractor(
      presenter: viewController,
      initialState: component.initailState,
      userUseCase: component.userUseCase)
    interactor.listener = listener
    return ProfileRouter(interactor: interactor, viewController: viewController)
  }
}
