import RIBs
@testable import Application

// MARK: - PostBuildableMock

class PostBuildableMock: Builder<PostDependency> {

  // MARK: Lifecycle

  init() {
    super.init(dependency: PostDependencyMock())
  }

  // MARK: Fileprivate

  fileprivate var initialState: SearchDisplayModel.State { .initialState() }
  fileprivate var userUseCase: UserUseCase {
    FirebaseUserUseCase(
      authenticating: FirebaseAuthentication(),
      apiNetworking: FirebaseAPINetwork())
  }
  fileprivate var postUseCase: PostUseCase {
    FirebasePostUseCase(
      apiNetworking: FirebaseAPINetwork(),
      mediaUploading: FirebaseMediaUploader())
  }

}

// MARK: PostBuildable

extension PostBuildableMock: PostBuildable {
  func build(withListener listener: PostListener, image: UIImage) -> PostRouting {
    _ = PostComponent(dependency: dependency)
    let viewController = PostViewController(node: .init())
    let interactor = PostInteractor(
      presenter: viewController,
      initialState: .init(photo: image, caption: "", isLoading: false, errorMessage: ""),
      postUseCase: postUseCase,
      userUseCase: userUseCase)
    interactor.listener = listener

    return PostRouter(
      interactor: interactor,
      viewController: viewController)
  }

}
