import RIBs

// MARK: - ProfileDependency

protocol ProfileDependency: Dependency {
}

// MARK: - ProfileComponent

final class ProfileComponent: Component<ProfileDependency> {
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
    _ = ProfileComponent(dependency: dependency)
    let viewController = ProfileViewController()
    let interactor = ProfileInteractor(presenter: viewController)
    interactor.listener = listener
    return ProfileRouter(interactor: interactor, viewController: viewController)
  }
}
