import RIBs

// MARK: - SearchDependency

protocol SearchDependency: Dependency {
}

// MARK: - SearchComponent

final class SearchComponent: Component<SearchDependency> {
  fileprivate var initailState: SearchDisplayModel.State { .initialState() }
}

// MARK: - SearchBuildable

protocol SearchBuildable: Buildable {
  func build(withListener listener: SearchListener) -> SearchRouting
}

// MARK: - SearchBuilder

final class SearchBuilder: Builder<SearchDependency>, SearchBuildable {

  // MARK: Lifecycle

  override init(dependency: SearchDependency) {
    super.init(dependency: dependency)
  }

  deinit {
    print("SearchBuilder deinit...")
  }

  // MARK: Internal

  func build(withListener listener: SearchListener) -> SearchRouting {
    let component = SearchComponent(dependency: dependency)
    let viewController = SearchViewController(node: .init())
    let interactor = SearchInteractor(
      presenter: viewController,
      initialState: component.initailState)
    interactor.listener = listener
    return SearchRouter(interactor: interactor, viewController: viewController)
  }
}
