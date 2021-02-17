import RIBs
@testable import Application

// MARK: - SearchBuildableMock

class SearchBuildableMock: Builder<SearchDependency> {

  init() {
    super.init(dependency: SearchDependencyMock())
  }

}

// MARK: SearchBuildable

extension SearchBuildableMock: SearchBuildable {
  func build(withListener listener: SearchListener) -> SearchRouting {
    _ = SearchComponent(dependency: dependency)
    let viewController = SearchViewController(node: .init())
    let interactor = SearchInteractor(presenter: viewController)
    interactor.listener = listener

    return SearchRouter(
      interactor: interactor,
      viewController: viewController)
  }

}
