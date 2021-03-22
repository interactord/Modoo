import RIBs

// MARK: - SubFeedDependency

protocol SubFeedDependency: Dependency {
}

// MARK: - SubFeedComponent

final class SubFeedComponent: Component<SubFeedDependency> {

  fileprivate var postUseCase: PostUseCase {
    FirebasePostUseCase(
      apiNetworking: FirebaseAPINetwork(),
      mediaUploading: FirebaseMediaUploader())
  }
}

// MARK: - SubFeedBuildable

protocol SubFeedBuildable: Buildable {
  func build(withListener listener: SubFeedListener, model: ProfileContentSectionModel.Cell) -> SubFeedRouting
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

  func build(withListener listener: SubFeedListener, model: ProfileContentSectionModel.Cell) -> SubFeedRouting {
    let component = SubFeedComponent(dependency: dependency)
    let viewController = SubFeedViewController(node: .init())
    let state = SubFeedDisplayModel.State(cellModel: model, originalState: .defaultValue())
    let interactor = SubFeedInteractor(
      presenter: viewController,
      initialState: state,
      postUseCase: component.postUseCase)
    interactor.listener = listener
    return SubFeedRouter(interactor: interactor, viewController: viewController)
  }
}
