import ReactorKit
import RIBs
import RxSwift

// MARK: - SubFeedRouting

protocol SubFeedRouting: ViewableRouting {
}

// MARK: - SubFeedPresentable

protocol SubFeedPresentable: Presentable {
  var listener: SubFeedPresentableListener? { get set }
}

// MARK: - SubFeedListener

protocol SubFeedListener: AnyObject {
  func routeToComment(item: FeedContentSectionModel.Cell)
  func routeToBackFromSubFeed()
  func routeToBackFromComment()
}

// MARK: - SubFeedInteractor

final class SubFeedInteractor: PresentableInteractor<SubFeedPresentable> {

  // MARK: Lifecycle

  init(
    presenter: SubFeedPresentable,
    initialState: SubFeedDisplayModel.State,
    postUseCase: PostUseCase)
  {
    defer { presenter.listener = self }
    self.initialState = initialState
    self.postUseCase = postUseCase
    super.init(presenter: presenter)
  }

  deinit {
    print("SubFeedInteractor deinit...")
  }

  // MARK: Internal

  weak var router: SubFeedRouting?
  weak var listener: SubFeedListener?

  var initialState: SubFeedDisplayModel.State
  let postUseCase: PostUseCase

}

// MARK: SubFeedPresentableListener, Reactor

extension SubFeedInteractor: SubFeedPresentableListener, Reactor {

  // MARK: Internal

  typealias Action = SubFeedDisplayModel.Action
  typealias State = SubFeedDisplayModel.State
  typealias Mutation = SubFeedDisplayModel.Mutation

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .tapClose:
      return mutatingTabClose()
    case .load:
      return mutatingLoad(cellModel: currentState.cellModel)
    case let .loading(isLoading):
      return .just(.setLoading(isLoading))
    case let .tabComment(item):
      return mutatingComment(item: item)
    }
  }

  func reduce(state: SubFeedDisplayModel.State, mutation: SubFeedDisplayModel.Mutation) -> SubFeedDisplayModel.State {
    var newState = state

    switch mutation {
    case let .setError(errorMessage):
      newState.errorMessage = errorMessage
    case let .setLoading(isLoading):
      newState.isLoading = isLoading
    case let .setPostContentCellItems(items):
      newState.postContentSectionModel = .init(cellItems: items, original: state.postContentSectionModel)
    case  let .setFocusIndex(index):
      newState.focusIndex = index
    }

    return newState
  }

  // MARK: Private

  private func mutatingTabClose() -> Observable<Mutation> {
    listener?.routeToBackFromSubFeed()
    return .empty()
  }

  private func mutatingLoad(cellModel: ProfileContentSectionModel.Cell) -> Observable<Mutation> {
    guard !currentState.isLoading else { return .empty() }

    let startLoading = Observable.just(Mutation.setLoading(true))
    let stopLoading = Observable.just(Mutation.setLoading(false))
    let useCaseStream = postUseCase.fetchPosts(uid: cellModel.uid).flatMap { repositoryModels -> Observable<Mutation> in
      let itemModels = repositoryModels.map{ FeedContentSectionModel.Cell(repositoryModel: $0) }
      let index = itemModels.firstIndex(where: { $0.id == cellModel.model.id }) ?? -1
      return .concat([
        .just(.setPostContentCellItems(itemModels)),
        .just(.setFocusIndex(index)),
      ])
    }
    .catch { .just(.setError($0.localizedDescription)) }

    return Observable.concat([startLoading, useCaseStream, stopLoading])
  }

  private func mutatingComment(item: FeedContentSectionModel.Cell) -> Observable<Mutation> {
    listener?.routeToComment(item: item)
    return .empty()
  }

}

// MARK: SubFeedInteractable

extension SubFeedInteractor: SubFeedInteractable {
  func routeToBackFromComment() {
    listener?.routeToBackFromComment()
  }
}
