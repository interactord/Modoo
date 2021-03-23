import RIBs

// MARK: - CommentDependency

protocol CommentDependency: Dependency {
}

// MARK: - CommentComponent

final class CommentComponent: Component<CommentDependency> {
  fileprivate var commentUseCase: CommentUseCase {
    FirebaseCommentUseCase(apiNetworking: FirebaseAPINetwork())
  }
}

// MARK: - CommentBuildable

protocol CommentBuildable: Buildable {
  func build(withListener listener: CommentListener, item: FeedContentSectionModel.Cell) -> CommentRouting
}

// MARK: - CommentBuilder

final class CommentBuilder: Builder<CommentDependency>, CommentBuildable {

  // MARK: Lifecycle

  override init(dependency: CommentDependency) {
    super.init(dependency: dependency)
  }

  deinit {
    print("CommentBuilder deinit...")
  }

  // MARK: Internal

  func build(withListener listener: CommentListener, item: FeedContentSectionModel.Cell) -> CommentRouting {
    let component = CommentComponent(dependency: dependency)
    let viewController = CommentViewController(node: .init())
    let state = CommentDisplayModel.State(postItem: item, oritinalState: .defaultValue())
    let interactor = CommentInteractor(
      presenter: viewController,
      initialState: state,
      commentUseCase: component.commentUseCase)
    interactor.listener = listener
    return CommentRouter(interactor: interactor, viewController: viewController)
  }
}
