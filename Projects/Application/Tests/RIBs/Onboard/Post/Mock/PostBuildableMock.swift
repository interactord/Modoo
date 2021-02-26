import RIBs
@testable import Application

// MARK: - PostBuildableMock

class PostBuildableMock: Builder<PostDependency> {

  init() {
    super.init(dependency: PostDependencyMock())
  }

}

// MARK: PostBuildable

extension PostBuildableMock: PostBuildable {
  func build(withListener listener: PostListener) -> PostRouting {
    _ = PostComponent(dependency: dependency)
    let viewController = PostViewController(node: .init())
    let interactor = PostInteractor(presenter: viewController)
    interactor.listener = listener

    return PostRouter(
      interactor: interactor,
      viewController: viewController)
  }

}
