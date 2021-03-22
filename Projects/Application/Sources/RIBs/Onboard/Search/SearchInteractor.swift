import ReactorKit
import RIBs
import RxSwift

// MARK: - SearchRouting

protocol SearchRouting: ViewableRouting {
  func routeToSubProfile(uid: String)
  func routeToSubFeed(model: ProfileContentSectionModel.Cell)
  func routeToBackFromSubFeed()
  func routeToBackFromSubProfile()
  func routeToComment(item: FeedContentSectionModel.Cell)
}

// MARK: - SearchPresentable

protocol SearchPresentable: Presentable {
  var listener: SearchPresentableListener? { get set }
}

// MARK: - SearchListener

protocol SearchListener: AnyObject {
}

// MARK: - SearchInteractor

final class SearchInteractor: PresentableInteractor<SearchPresentable> {

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

  weak var router: SearchRouting?
  weak var listener: SearchListener?

  var initialState: State
  let userUseCase: UserUseCase

}

// MARK: SearchInteractable

extension SearchInteractor: SearchInteractable {
  func routeToBackFromSubFeed() {
    router?.routeToBackFromSubFeed()
  }

  func routeToBackFromSubProfile() {
    router?.routeToBackFromSubProfile()
  }

  func routeToSubFeed(model: ProfileContentSectionModel.Cell) {
    router?.routeToSubFeed(model: model)
  }

  func routeToComment(item: FeedContentSectionModel.Cell) {
    router?.routeToComment(item: item)
  }
}

// MARK: SearchPresentableListener, Reactor

extension SearchInteractor: SearchPresentableListener, Reactor {

  // MARK: Internal

  typealias Action = SearchDisplayModel.Action
  typealias State = SearchDisplayModel.State
  typealias Mutation = SearchDisplayModel.Mutation

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .load:
      return mutatingLoad()
    case let .typingSearch(text):
      return .just(.setSearch(text))
    case let .loading(isLoading):
      return .just(.setLoading(isLoading))
    case  let .loadUser(item):
      return mutatingLoadUser(item: item)
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state

    switch mutation {
    case let .setUserContentSectionItemModel(cellItems):
      let newSectionItemModel = SectionDisplayModel<EmptyItemModel, SearchSectionItemModel.Cell, EmptyItemModel>(cellItems: cellItems, original: state.userContentSectionItemModel)
      newState.userContentSectionItemModel = newSectionItemModel
      newState.tempUserContentSectionItemModel = newSectionItemModel
    case let .setSearch(text):
      let filterCellItems = !text.isEmpty
        ? state.tempUserContentSectionItemModel.cellItems.filter({
          $0.userName.lowercased().contains(text.lowercased())
            || $0.fullName.lowercased().contains(text.lowercased())
        })
        : state.tempUserContentSectionItemModel.cellItems

      newState.userContentSectionItemModel = .init(cellItems: filterCellItems, original: state.userContentSectionItemModel)
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
    let uid = userUseCase.authenticationToken
    let useCaseStream = userUseCase.fetchUsers().flatMap { repositoryModels -> Observable<Mutation> in
      let filterdModels = repositoryModels.filter { $0.uid != uid }.map{ SearchSectionItemModel.Cell(repositoryModel: $0) }
      return .just(.setUserContentSectionItemModel(filterdModels))
    }
    .catch { .just(.setError($0.localizedDescription)) }

    return Observable.concat([startLoading, useCaseStream, stopLoading])
  }

  private func mutatingLoadUser(item: SearchSectionItemModel.Cell) -> Observable<Mutation> {
    router?.routeToSubProfile(uid: item.uid)
    return .empty()
  }
}
