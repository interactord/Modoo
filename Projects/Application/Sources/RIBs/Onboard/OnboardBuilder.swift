import RIBs

// MARK: - OnboardDependency

protocol OnboardDependency: Dependency {}

// MARK: - OnboardComponent

final class OnboardComponent: Component<OnboardDependency> {}

// MARK: FeedDependency

extension OnboardComponent: FeedDependency {
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
    let feedBuilderType: FeedBuilderAdapter.Type = BuilderContainer.resolve(for: FeedBuilderID)

    return OnboardRouter(
      interactor: interactor,
      viewController: viewController,
      feedBuilder: feedBuilderType.init(dependency: component))
  }
}
