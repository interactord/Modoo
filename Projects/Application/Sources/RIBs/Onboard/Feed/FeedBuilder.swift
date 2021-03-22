import RIBs

// MARK: - FeedDependency

protocol FeedDependency: Dependency {
}

// MARK: - FeedComponent

final class FeedComponent: Component<FeedDependency> {
  fileprivate var initailState: FeedDisplayModel.State { .defaultValue() }
  fileprivate var postUseCase: PostUseCase {
    FirebasePostUseCase(
      apiNetworking: FirebaseAPINetwork(),
      mediaUploading: FirebaseMediaUploader())
  }
}

// MARK: CommentDependency

extension FeedComponent: CommentDependency {
}

// MARK: - FeedBuildable

protocol FeedBuildable: Buildable {
  func build(withListener listener: FeedListener) -> FeedRouting
}

// MARK: - FeedBuilder

final class FeedBuilder: Builder<FeedDependency>, FeedBuildable {

  // MARK: Lifecycle

  override init(dependency: FeedDependency) {
    super.init(dependency: dependency)
  }

  deinit {
    print("FeedBuilder deinit...")
  }

  // MARK: Internal

  func build(withListener listener: FeedListener) -> FeedRouting {
    let component = FeedComponent(dependency: dependency)
    let viewController = FeedViewController(node: .init())
    let interactor = FeedInteractor(
      presenter: viewController,
      initialState: component.initailState,
      postUseCase: component.postUseCase)
    interactor.listener = listener

    let commentBuilderAdapterType: CommentBuilderAdapter.Type = BuilderContainer.resolve(for: CommentBuilderID)

    return FeedRouter(
      interactor: interactor,
      viewController: viewController,
      commentBuilder: commentBuilderAdapterType.init(dependency: component))
  }
}
