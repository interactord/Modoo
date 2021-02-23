import ReactorKit
import RIBs
import RxSwift

// MARK: - SearchRouting

protocol SearchRouting: ViewableRouting {
  func routeToSubProfile(uid: String)
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
    case setSearch(String)
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
    case let .typingSearch(text):
      return .just(.setSearch(text))
    case let .loading(isLoading):
      return .just(.setLoading(isLoading))
    case  let .loadUser(item):
      print(item)
      return .empty()
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state

    switch mutation {
    case let .setUserContentSectionItemModel(sectionItemModel):
      let sectionItemModel = SearchUserContentSectionItemModel(
        sectionID: state.userContentSectionItemModel.sectionID,
        sectionItem: sectionItemModel)
      newState.userContentSectionItemModel = sectionItemModel
      newState.tempUserContentSectionItemModel = sectionItemModel
    case let .setSearch(text):
      let filterCellItem = !text.isEmpty
        ? state.tempUserContentSectionItemModel.cellItems.filter({
          $0.userName.lowercased().contains(text.lowercased())
            || $0.fullName.lowercased().contains(text.lowercased())
        })
        : state.tempUserContentSectionItemModel.cellItems

      newState.userContentSectionItemModel = SearchUserContentSectionItemModel(
        sectionID: state.userContentSectionItemModel.sectionID, sectionItem: .init(items: filterCellItem))
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
