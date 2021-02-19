import ReactorKit
import RxSwift

// MARK: - FormLoginReactor

final class FormLoginReactor {

  // MARK: Lifecycle

  deinit {
    print("FormLoginReactor deinit...")
  }

  // MARK: Internal

  enum Action {
    case typingEmail(String)
    case typingPassword(String)
    case isAllInputValid(Bool)
  }

  enum Mutation {
    case setEmail(String)
    case setPassword(String)
    case setIsAllInputValid(Bool)
  }

  typealias State = LoginDisplayModel.FormState

  var initialState: State = .init()
}

// MARK: Reactor

extension FormLoginReactor: Reactor {

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .typingEmail(email):
      return .just(.setEmail(email))
    case let .typingPassword(password):
      return .just(.setPassword(password))
    case let .isAllInputValid(isValid):
      return .just(.setIsAllInputValid(isValid))
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state

    switch mutation {
    case let .setEmail(email):
      newState.email = email
    case let .setPassword(password):
      newState.password = password
    case let .setIsAllInputValid(isValid):
      print("aaaaa 1111 : ", isValid)
      newState.isAllInputValid = isValid
    }

    return newState
  }
}
