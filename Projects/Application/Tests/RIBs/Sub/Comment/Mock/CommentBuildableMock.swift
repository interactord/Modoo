import RIBs

@testable import Application

// MARK: - CommentBuildableMock

class CommentBuildableMock: Builder<CommentDependency> {

  init() {
    super.init(dependency: CommentDependencyMock())
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
      initialState: state)
    interactor.listener = listener

    return CommentRouter(
      interactor: interactor,
      viewController: viewController)
  }

}
