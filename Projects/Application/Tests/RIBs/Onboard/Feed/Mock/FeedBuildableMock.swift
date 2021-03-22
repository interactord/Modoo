import RIBs

@testable import Application

// MARK: - FeedBuildableMock

class FeedBuildableMock: Builder<FeedDependency> {

  // MARK: Lifecycle

  init() {
    super.init(dependency: FeedDependencyMock())
  }

  // MARK: Fileprivate

  fileprivate var initialState: FeedDisplayModel.State { .defaultValue() }
  fileprivate var postUseCase: PostUseCase {
    FirebasePostUseCase(
      apiNetworking: FirebaseAPINetwork(),
      mediaUploading: FirebaseMediaUploader())
  }

}

// MARK: FeedBuildable

extension FeedBuildableMock: FeedBuildable {
  func build(withListener listener: FeedListener) -> FeedRouting {
    _ = FeedComponent(dependency: dependency)
    let viewController = FeedViewController(node: .init())
    let interactor = FeedInteractor(
      presenter: viewController,
      initialState: initialState,
      postUseCase: postUseCase)
    interactor.listener = listener

    return FeedRouter(
      interactor: interactor,
      viewController: viewController,
      commentBuilder: CommentBuildableMock())
  }

}
