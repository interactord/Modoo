import RIBs

// MARK: - SubFeedDependency

protocol SubFeedDependency: Dependency {
}

// MARK: - SubFeedComponent

final class SubFeedComponent: Component<SubFeedDependency> {
}

// MARK: - SubFeedBuildable

protocol SubFeedBuildable: Buildable {
  func build(withListener listener: SubFeedListener) -> SubFeedRouting
}

// MARK: - SubFeedBuilder

final class SubFeedBuilder: Builder<SubFeedDependency>, SubFeedBuildable {

  // MARK: Lifecycle

  override init(dependency: SubFeedDependency) {
    super.init(dependency: dependency)
  }

  deinit {
    print("SubFeedBuilder deinit...")
  }

  // MARK: Internal

  func build(withListener listener: SubFeedListener) -> SubFeedRouting {
    let _ = SubFeedComponent(dependency: dependency)
    let viewController = SubFeedViewController(node: .init())
    let interactor = SubFeedInteractor(presenter: viewController)
    interactor.listener = listener
    return SubFeedRouter(interactor: interactor, viewController: viewController)
  }
}
