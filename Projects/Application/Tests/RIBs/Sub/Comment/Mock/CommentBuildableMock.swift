import RIBs

@testable import Application

// MARK: - CommentBuildableMock

class CommentBuildableMock: Builder<CommentDependency> {

  // MARK: Lifecycle

  init() {
    super.init(dependency: CommentDependencyMock())
  }

  // MARK: Fileprivate

  fileprivate var commentUseCase: CommentUseCase {
    FirebaseCommentUseCase(apiNetworking: FirebaseAPINetwork())
  }

}

// MARK: CommentBuildable

extension CommentBuildableMock: CommentBuildable {
  func build(withListener listener: CommentListener, item: FeedContentSectionModel.Cell) -> CommentRouting {
    _ = CommentComponent(dependency: dependency)
    let viewController = CommentViewController(node: .init())
    let state = CommentDisplayModel.State(postItem: item)
    let interactor = CommentInteractor(
      presenter: viewController,
      initialState: state,
      commentUseCase: commentUseCase)
    interactor.listener = listener

    return CommentRouter(
      interactor: interactor,
      viewController: viewController)
  }

}
