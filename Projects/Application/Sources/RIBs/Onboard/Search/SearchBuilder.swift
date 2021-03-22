import RIBs

// MARK: - SearchDependency

protocol SearchDependency: Dependency {
}

// MARK: - SearchComponent

final class SearchComponent: Component<SearchDependency> {
  fileprivate var initailState: SearchDisplayModel.State { .defaultValue() }
  fileprivate var userUseCase: UserUseCase {
    FirebaseUserUseCase(
      authenticating: FirebaseAuthentication(),
      apiNetworking: FirebaseAPINetwork())
  }
}

// MARK: SubProfileDependency

extension SearchComponent: SubProfileDependency {
}

// MARK: SubFeedDependency

extension SearchComponent: SubFeedDependency {
}

// MARK: CommentDependency

extension SearchComponent: CommentDependency {
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
      initialState: component.initailState,
      userUseCase: component.userUseCase)
    interactor.listener = listener

    let subProfileBuilderAdapterType: SubProfileBuilderAdapter.Type = BuilderContainer.resolve(for: SubProfileBuilderID)
    let subFeedBuilderAdapterType: SubFeedBuilderAdapter.Type = BuilderContainer.resolve(for: SubFeedBuilderID)
    let commentBuilderAdapterType: CommentBuilderAdapter.Type = BuilderContainer.resolve(for: CommentBuilderID)

    return SearchRouter(
      interactor: interactor,
      viewController: viewController,
      subProfileBuilder: subProfileBuilderAdapterType.init(dependency: component),
      subFeedBuilder: subFeedBuilderAdapterType.init(dependency: component),
      commentBuilder: commentBuilderAdapterType.init(dependency: component))
  }
}
