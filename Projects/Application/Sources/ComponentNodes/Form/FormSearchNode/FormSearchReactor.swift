import Foundation
import ReactorKit
import RxSwift

// MARK: - FormSearchReactor

final class FormSearchReactor {

  // MARK: Lifecycle

  deinit {
    print("ForSearchReactor deinit...")
  }

  // MARK: Internal

  enum Action {
    case showCancelButton
    case hideCancelButton
  }

  enum Mutation {
    case setIsShowCancelButton(Bool)
  }

  struct State {
    var isShowCancelButton = false
  }

  let initialState = State()
}

// MARK: Reactor

extension FormSearchReactor: Reactor {

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .showCancelButton:
      return .just(.setIsShowCancelButton(true))
    case .hideCancelButton:
      return .just(.setIsShowCancelButton(false))
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state

    switch mutation {
    case let .setIsShowCancelButton(isShowCancelButton):
      newState.isShowCancelButton = isShowCancelButton
    }

    return newState
  }
}
