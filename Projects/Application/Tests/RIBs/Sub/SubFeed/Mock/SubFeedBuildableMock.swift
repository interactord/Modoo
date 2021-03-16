import RIBs

@testable import Application

// MARK: - SubFeedBuildableMock

class SubFeedBuildableMock: Builder<SubFeedDependency> {

  init() {
    super.init(dependency: SubFeedDependencyMock())
  }

}

// MARK: SubFeedBuildable

extension SubFeedBuildableMock: SubFeedBuildable {
  func build(withListener listener: SubFeedListener) -> SubFeedRouting {
    _ = SubFeedComponent(dependency: dependency)
    let viewController = SubFeedViewController(node: .init())
    let interactor = SubFeedInteractor(presenter: viewController)
    interactor.listener = listener

    return SubFeedRouter(
      interactor: interactor,
      viewController: viewController)
  }

}
