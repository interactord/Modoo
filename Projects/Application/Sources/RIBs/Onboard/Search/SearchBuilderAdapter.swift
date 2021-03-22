import RIBs

let SearchBuilderID = "SearchBuilderID"

// MARK: - SearchBuilderAdapter

final class SearchBuilderAdapter: Builder<SearchDependency> {

  // MARK: Lifecycle

  deinit {
    print("SearchBuilderAdapter deinit...")
  }

  // MARK: Private

  private final class Component: RIBs.Component<SearchDependency>, SearchDependency {
  }

  private weak var listener: SearchListener?

}

// MARK: SearchListener

extension SearchBuilderAdapter: SearchListener {
}

// MARK: SearchBuildable

extension SearchBuilderAdapter: SearchBuildable {
  func build(withListener listener: SearchListener) -> SearchRouting {
    let component = Component(dependency: dependency)
    self.listener = listener

    let builder = SearchBuilder(dependency: component)
    return builder.build(withListener: self)
  }

}
