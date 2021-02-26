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
  func build(withListener listener: PostListener, image: UIImage) -> PostRouting {
    _ = PostComponent(dependency: dependency)
    let viewController = PostViewController(node: .init())
    let interactor = PostInteractor(
      presenter: viewController,
      initialState: .init(photo: image, caption: "", isLoading: false, errorMessage: ""))
    interactor.listener = listener

    return PostRouter(
      interactor: interactor,
      viewController: viewController)
  }

}
