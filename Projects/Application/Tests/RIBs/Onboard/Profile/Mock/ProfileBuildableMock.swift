import RIBs
@testable import Application

// MARK: - ProfileBuildableMock

class ProfileBuildableMock: Builder<ProfileDependency> {

  // MARK: Lifecycle

  init() {
    super.init(dependency: ProfileDependencyMock())
  }

  // MARK: Fileprivate

  fileprivate var initialState: ProfileDisplayModel.State { .initialState() }
  fileprivate var userUseCase: UserUseCase {
    FirebaseUserUseCase(
      authenticating: FirebaseAuthentication(),
      apiNetworking: FirebaseAPINetwork())
  }

}

// MARK: ProfileBuildable

extension ProfileBuildableMock: ProfileBuildable {
  func build(withListener listener: ProfileListener) -> ProfileRouting {
    _ = ProfileComponent(dependency: dependency)
    let viewController = ProfileViewController(node: .init())
    let interactor = ProfileInteractor(
      presenter: viewController,
      initialState: initialState,
      userUseCase: userUseCase)
    interactor.listener = listener

    return ProfileRouter(
      interactor: interactor,
      viewController: viewController)
  }

}
