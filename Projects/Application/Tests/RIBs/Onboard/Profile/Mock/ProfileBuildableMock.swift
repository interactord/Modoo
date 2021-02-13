import RIBs
@testable import Application

// MARK: - ProfileBuildableMock

class ProfileBuildableMock: Builder<ProfileDependency> {

  init() {
    super.init(dependency: ProfileDependencyMock())
  }

}

// MARK: ProfileBuildable

extension ProfileBuildableMock: ProfileBuildable {
  func build(withListener listener: ProfileListener) -> ProfileRouting {
    _ = ProfileComponent(dependency: dependency)
    let viewController = ProfileViewController()
    let interactor = ProfileInteractor(presenter: viewController)
    interactor.listener = listener

    return ProfileRouter(
      interactor: interactor,
      viewController: viewController)
  }

}
