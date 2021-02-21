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
    initialState: SearchDisplayModel.State)
  {
    defer { presenter.listener = self }
    self.initialState = initialState
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
  }

  weak var router: SearchRouting?
  weak var listener: SearchListener?

  var initialState: State

}

// MARK: SearchPresentableListener, Reactor

extension SearchInteractor: SearchPresentableListener, Reactor {

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .loading(isLoading):
      return .just(.setLoading(isLoading))
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state

    switch mutation {
    case let .setLoading(isLoading):
      newState.isLoading = isLoading
    }

    return newState
  }
}
