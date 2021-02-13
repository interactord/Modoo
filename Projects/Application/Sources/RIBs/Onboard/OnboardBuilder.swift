import RIBs

// MARK: - OnboardDependency

protocol OnboardDependency: Dependency {}

// MARK: - OnboardComponent

final class OnboardComponent: Component<OnboardDependency> {}

// MARK: FeedDependency

extension OnboardComponent: FeedDependency {
}

// MARK: ProfileDependency

extension OnboardComponent: ProfileDependency {
}

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
    let viewController = OnboardViewController()
    let interactor = OnboardInteractor(presenter: viewController)
    interactor.listener = listener

    let component = OnboardComponent(dependency: dependency)
    let feedBuilderAdapterType: FeedBuilderAdapter.Type = BuilderContainer.resolve(for: FeedBuilderID)
    let profileBuilderAdapterType: ProfileBuilderAdapter.Type = BuilderContainer.resolve(for: ProfileBuilderID)

    return OnboardRouter(
      interactor: interactor,
      viewController: viewController,
      feedBuilder: feedBuilderAdapterType.init(dependency: component),
      profileBuilder: profileBuilderAdapterType.init(dependency: component))
  }
}
