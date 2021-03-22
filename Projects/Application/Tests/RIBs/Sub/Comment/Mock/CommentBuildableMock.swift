import RIBs

@testable import Application

// MARK: - CommentBuildableMock

class CommentBuildableMock: Builder<CommentDependency> {

  // MARK: Lifecycle

  init() {
    super.init(dependency: CommentDependencyMock())
  }

  // MARK: Fileprivate

  fileprivate var initialState: CommentDisplayModel.State { .defaultValue() }

}

// MARK: CommentBuildable

extension CommentBuildableMock: CommentBuildable {
  func build(withListener listener: CommentListener) -> CommentRouting {
    _ = CommentComponent(dependency: dependency)
    let viewController = CommentViewController(node: .init())
    let interactor = CommentInteractor(
      presenter: viewController,
      initialState: initialState)
    interactor.listener = listener

    return CommentRouter(
      interactor: interactor,
      viewController: viewController)
  }

}
