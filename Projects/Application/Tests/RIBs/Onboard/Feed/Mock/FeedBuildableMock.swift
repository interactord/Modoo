import RIBs

@testable import Application

// MARK: - FeedBuildableMock

class FeedBuildableMock: Builder<FeedDependency> {

  init() {
    super.init(dependency: FeedDependencyMock())
  }

}

// MARK: FeedBuildable

extension FeedBuildableMock: FeedBuildable {
  func build(withListener listener: FeedListener) -> FeedRouting {
    _ = FeedComponent(dependency: dependency)
    let viewController = FeedViewController()
    let interactor = FeedInteractor(presenter: viewController)
    interactor.listener = listener

    return FeedRouter(
      interactor: interactor,
      viewController: viewController)
  }

}
