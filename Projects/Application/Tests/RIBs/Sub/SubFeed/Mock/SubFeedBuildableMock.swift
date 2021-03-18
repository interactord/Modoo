import RIBs

@testable import Application

// MARK: - SubFeedBuildableMock

class SubFeedBuildableMock: Builder<SubFeedDependency> {

  // MARK: Lifecycle

  init() {
    super.init(dependency: SubFeedDependencyMock())
  }

  // MARK: Fileprivate

  fileprivate var initialState: SubFeedDisplayModel.State { .initialState() }
}

// MARK: SubFeedBuildable

extension SubFeedBuildableMock: SubFeedBuildable {
  func build(withListener listener: SubFeedListener) -> SubFeedRouting {
    _ = SubFeedComponent(dependency: dependency)
    let viewController = SubFeedViewController(node: .init())
    let interactor = SubFeedInteractor(
      presenter: viewController,
      initialState: initialState)
    interactor.listener = listener

    return SubFeedRouter(
      interactor: interactor,
      viewController: viewController)
  }

}
