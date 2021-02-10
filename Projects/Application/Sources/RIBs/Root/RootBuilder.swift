import RIBs

// MARK: - RootDependency

protocol RootDependency: Dependency {
}

// MARK: - RootComponent

final class RootComponent: Component<RootDependency> {

  // MARK: Lifecycle

  init(
    dependency: RootDependency,
    rootViewController: RootViewController)
  {
    self.rootViewController = rootViewController

    super.init(dependency: dependency)
  }

  // MARK: Internal

  let rootViewController: RootViewController

  // MARK: Fileprivate

  fileprivate var authenticationUseCase: AuthenticationUseCase {
    FirebaseAuthenticationUseCase(
      authenticating: FirebaseAuthentication(),
      uploading: FirebaseMediaUploader(),
      apiNetworking: FirebaseAPINetwork())
  }

}

// MARK: RootDependency

extension RootComponent: RootDependency {
}

// MARK: AuthenticationDependency

extension RootComponent: AuthenticationDependency {
}

// MARK: OnboardDependency

extension RootComponent: OnboardDependency {}

// MARK: - RootBuildable

protocol RootBuildable: Buildable {
  func build() -> LaunchRouting
}

// MARK: - RootBuilder

final class RootBuilder: Builder<RootDependency> {

  override init(dependency: RootDependency) {
    super.init(dependency: dependency)
  }

}

// MARK: RootBuildable

extension RootBuilder: RootBuildable {
  func build() -> LaunchRouting {
    let viewController = RootViewController()
    let interactor = RootInteractor(presenter: viewController)

    let component = RootComponent(
      dependency: dependency,
      rootViewController: viewController)

    let authenticationBuilderType: AuthenticationBuilderAdapter.Type = BuilderContainer.resolve(for: AuthenticationBuilderID)
    let authenticationBuilder = authenticationBuilderType.init(dependency: component)
    let onboardBuilder = OnboardBuilder(dependency: component)

    return RootRouter(
      interactor: interactor,
      viewController: viewController,
      authenticationBuilder: authenticationBuilder,
      onboardBuilder: onboardBuilder,
      authenticationUseCase: component.authenticationUseCase)

  }
}
