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
  func routeToClose()
}

// MARK: - SubFeedInteractor

final class SubFeedInteractor: PresentableInteractor<SubFeedPresentable>, SubFeedInteractable {

  // MARK: Lifecycle

  init(
    presenter: SubFeedPresentable,
    initialState: SubFeedDisplayModel.State)
  {
    defer { presenter.listener = self }
    self.initialState = initialState
    super.init(presenter: presenter)
  }

  deinit {
    print("SubFeedInteractor deinit...")
  }

  // MARK: Internal

  typealias Action = SubFeedPresentableAction
  typealias State = SubFeedDisplayModel.State

  enum Mutation: Equatable {
  }

  weak var router: SubFeedRouting?
  weak var listener: SubFeedListener?

  var initialState: SubFeedDisplayModel.State

}

// MARK: SubFeedPresentableListener, Reactor

extension SubFeedInteractor: SubFeedPresentableListener, Reactor {

  // MARK: Internal

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .tapClose:
      return mutatingTabClose()
    }
  }

  // MARK: Private

  private func mutatingTabClose() -> Observable<Mutation> {
    listener?.routeToClose()
    return .empty()
  }
}
