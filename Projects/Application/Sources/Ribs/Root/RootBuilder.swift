import RIBs

protocol RootDependency: Dependency {}

// MARK: - Component

final class RootComponent: Component<RootDependency> {
  let rootViewController: RootViewController

  init(dependency: RootDependency,
       rootViewController: RootViewController)
  {
    self.rootViewController = rootViewController

    super.init(dependency: dependency)
  }
}

extension RootComponent: LoginDependency {}
extension RootComponent: OnboardDependency {}

// MARK: - Builder

protocol RootBuildable: Buildable {
  func build() -> LaunchRouting
}

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

    let component = RootComponent(dependency: dependency,
                                  rootViewController: viewController)
    let loginBuilder = LoginBuilder(dependency: component)
    let onboardBuilder = OnboardBuilder(dependency: component)

    return RootRouter(interactor: interactor,
                      viewController: viewController,
                      loginBuilder: loginBuilder,
                      onboardBuilder: onboardBuilder)
  }
}
