import RIBs
@testable import Application

// MARK: - SearchBuildableMock

class SearchBuildableMock: Builder<SearchDependency> {

  // MARK: Lifecycle

  init() {
    super.init(dependency: SearchDependencyMock())
  }

  // MARK: Fileprivate

  fileprivate var initialState: SearchDisplayModel.State { .defaultValue() }
  fileprivate var userUseCase: UserUseCase {
    FirebaseUserUseCase(
      authenticating: FirebaseAuthentication(),
      apiNetworking: FirebaseAPINetwork())
  }

}

// MARK: SearchBuildable

extension SearchBuildableMock: SearchBuildable {
  func build(withListener listener: SearchListener) -> SearchRouting {
    _ = SearchComponent(dependency: dependency)
    let viewController = SearchViewController(node: .init())
    let interactor = SearchInteractor(
      presenter: viewController,
      initialState: initialState,
      userUseCase: userUseCase)
    interactor.listener = listener

    return SearchRouter(
      interactor: interactor,
      viewController: viewController,
      subProfileBuilder: SubProfileBuildableMock())
  }

}
