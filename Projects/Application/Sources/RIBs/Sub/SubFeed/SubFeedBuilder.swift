import RIBs

// MARK: - SubFeedDependency

protocol SubFeedDependency: Dependency {
}

// MARK: - SubFeedComponent

final class SubFeedComponent: Component<SubFeedDependency> {
  fileprivate var initailState: SubFeedDisplayModel.State { .defaultValue() }

  fileprivate var postUseCase: PostUseCase {
    FirebasePostUseCase(
      apiNetworking: FirebaseAPINetwork(),
      mediaUploading: FirebaseMediaUploader())
  }
}

// MARK: - SubFeedBuildable

protocol SubFeedBuildable: Buildable {
  func build(withListener listener: SubFeedListener) -> SubFeedRouting
}

// MARK: - SubFeedBuilder

final class SubFeedBuilder: Builder<SubFeedDependency>, SubFeedBuildable {

  // MARK: Lifecycle

  override init(dependency: SubFeedDependency) {
    super.init(dependency: dependency)
  }

  deinit {
    print("SubFeedBuilder deinit...")
  }

  // MARK: Internal

  func build(withListener listener: SubFeedListener) -> SubFeedRouting {
    let component = SubFeedComponent(dependency: dependency)
    let viewController = SubFeedViewController(node: .init())
    let interactor = SubFeedInteractor(
      presenter: viewController,
      initialState: component.initailState,
      postUseCase: component.postUseCase)
    interactor.listener = listener
    return SubFeedRouter(interactor: interactor, viewController: viewController)
  }
}
