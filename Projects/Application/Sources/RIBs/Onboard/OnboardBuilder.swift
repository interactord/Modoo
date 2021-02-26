import RIBs

// MARK: - OnboardDependency

protocol OnboardDependency: Dependency {}

// MARK: - OnboardComponent

final class OnboardComponent: Component<OnboardDependency> {
  fileprivate var initailState: OnboardDisplayModel.State { .initialState() }
  fileprivate var postMediaPickerUseCase: PostMediaPickerUseCase {
    YPPostMediaPickerUseCase()
  }
}

// MARK: FeedDependency

extension OnboardComponent: FeedDependency {
}

// MARK: ProfileDependency

extension OnboardComponent: ProfileDependency {
}

// MARK: SearchDependency

extension OnboardComponent: SearchDependency {
}

// MARK: PostDependency

extension OnboardComponent: PostDependency {
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
    let component = OnboardComponent(dependency: dependency)
    let viewController = OnboardViewController(postMediaUseCase: component.postMediaPickerUseCase)
    let interactor = OnboardInteractor(
      presenter: viewController,
      initialState: component.initailState)
    interactor.listener = listener

    let feedBuilderAdapterType: FeedBuilderAdapter.Type = BuilderContainer.resolve(for: FeedBuilderID)
    let profileBuilderAdapterType: ProfileBuilderAdapter.Type = BuilderContainer.resolve(for: ProfileBuilderID)
    let searchBulderAdapterType: SearchBuilderAdapter.Type = BuilderContainer.resolve(for: SearchBuilderID)
    let postBuilderAdapterType: PostBuilderAdapter.Type = BuilderContainer.resolve(for: PostBuilderID)

    return OnboardRouter(
      interactor: interactor,
      viewController: viewController,
      feedBuilder: feedBuilderAdapterType.init(dependency: component),
      profileBuilder: profileBuilderAdapterType.init(dependency: component),
      searchBuilder: searchBulderAdapterType.init(dependency: component),
      postBuilder: postBuilderAdapterType.init(dependency: component))
  }
}
