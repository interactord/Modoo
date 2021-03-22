import RIBs

@testable import Application

// MARK: - SubFeedBuildableMock

class SubFeedBuildableMock: Builder<SubFeedDependency> {

  // MARK: Lifecycle

  init() {
    super.init(dependency: SubFeedDependencyMock())
  }

  // MARK: Fileprivate

  fileprivate var initialState: SubFeedDisplayModel.State { .defaultValue() }
  fileprivate var postUseCase: PostUseCase {
    FirebasePostUseCase(
      apiNetworking: FirebaseAPINetwork(),
      mediaUploading: FirebaseMediaUploader())
  }
}

// MARK: SubFeedBuildable

extension SubFeedBuildableMock: SubFeedBuildable {
  func build(withListener listener: SubFeedListener, model: ProfileContentSectionModel.Cell) -> SubFeedRouting {
    _ = SubFeedComponent(dependency: dependency)
    let viewController = SubFeedViewController(node: .init())
    let interactor = SubFeedInteractor(
      presenter: viewController,
      initialState: initialState,
      postUseCase: postUseCase)
    interactor.listener = listener

    return SubFeedRouter(
      interactor: interactor,
      viewController: viewController,
      commentBuilder: CommentBuildableMock())
  }

}
