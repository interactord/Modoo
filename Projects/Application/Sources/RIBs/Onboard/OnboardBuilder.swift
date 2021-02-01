import RIBs

// MARK: - OnboardDependency

protocol OnboardDependency: Dependency {}

// MARK: - OnboardComponent

final class OnboardComponent: Component<OnboardDependency> {}

// MARK: - OnboardBuildable

protocol OnboardBuildable: Buildable {
  func build(withListener listener: OnboardListener) -> OnboardRouting
}

// MARK: - OnboardBuilder

final class OnboardBuilder: Builder<OnboardDependency> {
  override init(dependency: OnboardDependency) {
    super.init(dependency: dependency)
  }
}

// MARK: OnboardBuildable

extension OnboardBuilder: OnboardBuildable {
  func build(withListener listener: OnboardListener) -> OnboardRouting {
    _ = OnboardComponent(dependency: dependency)

    let viewController = OnboardViewController()
    let interactor = OnboardInteractor(presenter: viewController)
    interactor.listener = listener
    return OnboardRouter(interactor: interactor, viewController: viewController)
  }
}
