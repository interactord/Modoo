import ReactorKit
import RIBs
import RxSwift

// MARK: - SearchRouting

protocol SearchRouting: ViewableRouting {
}

// MARK: - SearchPresentable

protocol SearchPresentable: Presentable {
  var listener: SearchPresentableListener? { get set }
}

// MARK: - SearchListener

protocol SearchListener: AnyObject {
}

// MARK: - SearchInteractor

final class SearchInteractor: PresentableInteractor<SearchPresentable>, SearchInteractable {

  // MARK: Lifecycle

  init(
    presenter: SearchPresentable,
    initialState: SearchDisplayModel.State,
    userUseCase: UserUseCase)
  {
    defer { presenter.listener = self }
    self.initialState = initialState
    self.userUseCase = userUseCase
    super.init(presenter: presenter)
  }

  deinit {
    print("SearchInteractor deinit...")
  }

  // MARK: Internal

  typealias Action = SearchPresentableAction
  typealias State = SearchDisplayModel.State

  enum Mutation: Equatable {
    case setLoading(Bool)
    case setError(String)
    case setUserContentSectionItemModel(SearchDisplayModel.SearchContentSectionItem)
  }

  weak var router: SearchRouting?
  weak var listener: SearchListener?

  var initialState: State
  let userUseCase: UserUseCase

}

// MARK: SearchPresentableListener, Reactor

extension SearchInteractor: SearchPresentableListener, Reactor {

  // MARK: Internal

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .load:
      return mutatingLoad()
    case let .loading(isLoading):
      return .just(.setLoading(isLoading))
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state

    switch mutation {
    case let .setUserContentSectionItemModel(sectionItemModel):
      newState.userContentSectionItemModel = SearchUserContentSectionItemModel(
        sectionID: state.userContentSectionItemModel.sectionID,
        sectionItem: sectionItemModel)
    case let .setLoading(isLoading):
      newState.isLoading = isLoading
    case let .setError(errorMessage):
      newState.errorMessage = errorMessage
    }

    return newState
  }

  // MARK: Private

  private func mutatingLoad() -> Observable<Mutation> {
    guard !currentState.isLoading else { return .empty() }

    let startLoading = Observable.just(Mutation.setLoading(true))
    let stopLoading = Observable.just(Mutation.setLoading(false))
    let useCaseStream = userUseCase.fetchUsers().flatMap { repositoryModels -> Observable<Mutation> in
      let sectionItemModel = SearchDisplayModel.SearchContentSectionItem(repositoryModels: repositoryModels)
      return .just(.setUserContentSectionItemModel(sectionItemModel))
    }
    .catch { .just(.setError($0.localizedDescription)) }

    return Observable.concat([startLoading, useCaseStream, stopLoading])
  }
}
