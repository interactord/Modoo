import ReactorKit
import RIBs
import RxSwift

// MARK: - PostRouting

protocol PostRouting: ViewableRouting {
}

// MARK: - PostPresentable

protocol PostPresentable: Presentable {
  var listener: PostPresentableListener? { get set }
}

// MARK: - PostListener

protocol PostListener: AnyObject {
  func routeToClose()
}

// MARK: - PostInteractor

final class PostInteractor: PresentableInteractor<PostPresentable>, PostInteractable {

  // MARK: Lifecycle

  init(
    presenter: PostPresentable,
    initialState: PostDisplayModel.State,
    postUseCase: PostUseCase,
    userUseCase: UserUseCase)
  {
    self.initialState = initialState
    self.postUseCase = postUseCase
    self.userUseCase = userUseCase
    defer { presenter.listener = self }
    super.init(presenter: presenter)
  }

  deinit {
    print("PostInteractor deinit...")
  }

  // MARK: Internal

  typealias Action = PostPresentableAction
  typealias State = PostDisplayModel.State

  enum Mutation: Equatable {
    case setCaption(String)
    case setLoading(Bool)
    case setError(String)
  }

  weak var router: PostRouting?
  weak var listener: PostListener?
  var initialState: PostDisplayModel.State
  let postUseCase: PostUseCase
  let userUseCase: UserUseCase

}

// MARK: PostPresentableListener, Reactor

extension PostInteractor: PostPresentableListener, Reactor {

  // MARK: Internal

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .cancel:
      return mutatingCancel()
    case let .typingCaption(text):
      return .just(.setCaption(text))
    case .share:
      return mutatingShare()
    case let .loading(isLoading):
      return .just(.setLoading(isLoading))
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state

    switch mutation {
    case let .setCaption(text):
      newState.caption = text
    case let .setLoading(isLoading):
      newState.isLoading = isLoading
    case let .setError(message):
      newState.errorMessage = message
    }

    return newState
  }

  // MARK: Private

  private func mutatingCancel() -> Observable<Mutation> {
    listener?.routeToClose()
    return .empty()
  }

  private func mutatingShare() -> Observable<Mutation> {
    guard !currentState.isLoading else { return .empty() }

    let startLoading = Observable.just(Mutation.setLoading(true))
    let stopLoading = Observable.just(Mutation.setLoading(false))
    let useCaseStream = userUseCase
      .fetchUser(uid: userUseCase.authenticationToken)
      .withUnretained(self)
      .flatMap { $0.0.postUseCase.uploadPost(displayModel: $0.0.currentState, user: $0.1) }
      .withUnretained(self)
      .observe(on: MainScheduler.asyncInstance)
      .flatMap { $0.0.mutatingCancel() }
      .catch { .just(.setError($0.localizedDescription)) }

    return Observable.concat([startLoading, useCaseStream, stopLoading])
  }
}
