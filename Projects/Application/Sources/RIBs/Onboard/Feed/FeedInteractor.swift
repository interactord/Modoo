import ReactorKit
import RIBs
import RxSwift

// MARK: - FeedRouting

protocol FeedRouting: ViewableRouting {
  func routeToComment(item: FeedContentSectionModel.Cell)
}

// MARK: - FeedPresentable

protocol FeedPresentable: Presentable {
  var listener: FeedPresentableListener? { get set }
}

// MARK: - FeedListener

protocol FeedListener: AnyObject {
}

// MARK: - FeedInteractor

final class FeedInteractor: PresentableInteractor<FeedPresentable>, FeedInteractable {

  // MARK: Lifecycle

  init(
    presenter: FeedPresentable,
    initialState: FeedDisplayModel.State,
    postUseCase: PostUseCase)
  {
    self.initialState = initialState
    self.postUseCase = postUseCase
    defer { presenter.listener = self }
    super.init(presenter: presenter)
  }

  deinit {
    print("FeedInteractor deinit...")
  }

  // MARK: Internal

  weak var router: FeedRouting?
  weak var listener: FeedListener?

  var initialState: FeedDisplayModel.State
  let postUseCase: PostUseCase

}

// MARK: FeedPresentableListener, Reactor

extension FeedInteractor: FeedPresentableListener, Reactor {

  // MARK: Internal

  typealias Action = FeedDisplayModel.Action
  typealias Mutation = FeedDisplayModel.Mutation
  typealias State = FeedDisplayModel.State

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .load:
      return mutatingLoad()
    case let .loading(isLoading):
      return .just(.setLoading(isLoading))
    case let .tabComment(item):
      return mutatingComment(item: item)
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state

    switch mutation {
    case let .setPostContentCellItems(items):
      newState.postContentSectionModel = .init(cellItems: items, original: state.postContentSectionModel)
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
    let useCaseStream = postUseCase.fetchPosts().flatMap { repositoryModels -> Observable<Mutation> in
      let itemModels = repositoryModels.map{ FeedContentSectionModel.Cell(repositoryModel: $0) }
      return .just(.setPostContentCellItems(itemModels))
    }
    .catch { .just(.setError($0.localizedDescription)) }

    return Observable.concat([startLoading, useCaseStream, stopLoading])
  }

  private func mutatingComment(item: FeedContentSectionModel.Cell) -> Observable<Mutation> {
    router?.routeToComment(item: item)
    return .empty()
  }
}
