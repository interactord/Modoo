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
  func build(withListener listener: CommentListener) -> CommentRouting {
    _ = CommentComponent(dependency: dependency)
    let viewController = CommentViewController(node: .init())
    let interactor = CommentInteractor(presenter: viewController)
    interactor.listener = listener

    return CommentRouter(
      interactor: interactor,
      viewController: viewController)
  }

}
