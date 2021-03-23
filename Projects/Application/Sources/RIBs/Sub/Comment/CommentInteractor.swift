import ReactorKit
import RIBs
import RxSwift

// MARK: - CommentRouting

protocol CommentRouting: ViewableRouting {
}

// MARK: - CommentPresentable

protocol CommentPresentable: Presentable {
  var listener: CommentPresentableListener? { get set }
}

// MARK: - CommentListener

protocol CommentListener: AnyObject {
  func routeToBackFromComment()
}

// MARK: - CommentInteractor

final class CommentInteractor: PresentableInteractor<CommentPresentable>, CommentInteractable {

  // MARK: Lifecycle

  init(
    presenter: CommentPresentable,
    initialState: CommentDisplayModel.State,
    commentUseCase: CommentUseCase)
  {
    defer { presenter.listener = self }
    self.initialState = initialState
    self.commentUseCase = commentUseCase
    super.init(presenter: presenter)
  }

  deinit {
    print("CommentInteractor deinit...")
  }

  // MARK: Internal

  weak var router: CommentRouting?
  weak var listener: CommentListener?

  var initialState: CommentDisplayModel.State
  let commentUseCase: CommentUseCase

}

// MARK: CommentPresentableListener, Reactor

extension CommentInteractor: CommentPresentableListener, Reactor {

  // MARK: Internal

  typealias Action = CommentDisplayModel.Action
  typealias State = CommentDisplayModel.State
  typealias Mutation = CommentDisplayModel.Mutation

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .back:
      return mutatingBack()
    case .load:
      return mutatingLoad(postID: currentState.postItem.id)
    case let .loading(isLoading):
      return .just(.setLoading(isLoading))
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state

    switch mutation {
    case let .setError(errorMessage):
      newState.errorMessage = errorMessage
    case let .setLoading(isLoading):
      newState.isLoading = isLoading
    }

    return newState
  }

  // MARK: Private

  private func mutatingBack() -> Observable<Mutation> {
    listener?.routeToBackFromComment()
    return .empty()
  }

  private func mutatingLoad(postID: String) -> Observable<Mutation> {
    guard !currentState.isLoading else { return .empty() }

    let startLoading = Observable.just(Mutation.setLoading(true))
    let stopLoading = Observable.just(Mutation.setLoading(false))
    let useCaseStream = commentUseCase
      .fetchComment(postID: postID)
      .flatMap { repositoryModel -> Observable<Mutation> in
        .just(.setLoading(false))
      }
      .catch{ .just(.setError($0.localizedDescription)) }

    return .concat([
      startLoading,
      useCaseStream,
      stopLoading,
    ])
  }
}
