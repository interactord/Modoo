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
  func dismissPost()
}

// MARK: - PostInteractor

final class PostInteractor: PresentableInteractor<PostPresentable>, PostInteractable {

  // MARK: Lifecycle

  init(
    presenter: PostPresentable,
    initialState: PostDisplayModel.State)
  {
    self.initialState = initialState
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
  }

  weak var router: PostRouting?
  weak var listener: PostListener?
  var initialState: PostDisplayModel.State

}

// MARK: PostPresentableListener, Reactor

extension PostInteractor: PostPresentableListener, Reactor {

  // MARK: Internal

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .cancel:
      return mutatingCancel()
    }
  }

  // MARK: Private

  private func mutatingCancel() -> Observable<Mutation> {
    listener?.dismissPost()
    return .empty()
  }
}
