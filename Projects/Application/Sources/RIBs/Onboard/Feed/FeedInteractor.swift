import ReactorKit
import RIBs
import RxSwift

// MARK: - FeedRouting

protocol FeedRouting: ViewableRouting {
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
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state

    switch mutation {
    case let .setPostContentSectionItem(item):
      let sectionID = state.postContentSectionModel.sectionID
      newState.postContentSectionModel = .init(sectionID: sectionID, sectionItem: item)
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
    let useCaseStream = postUseCase.fetchPosts().flatMap { repositoryModel -> Observable<Mutation> in
      .just(.setPostContentSectionItem(.init(postRepositoryModels: repositoryModel)))
    }
    .catch { .just(.setError($0.localizedDescription)) }

    return Observable.concat([startLoading, useCaseStream, stopLoading])
  }
}
