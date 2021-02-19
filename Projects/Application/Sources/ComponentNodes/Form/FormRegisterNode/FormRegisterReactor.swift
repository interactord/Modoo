import ReactorKit
import RxSwift

// MARK: - FormRegisterReactor

final class FormRegisterReactor {

  // MARK: Lifecycle

  deinit {
    print("FormRegisterReactor deinit...")
  }

  // MARK: Internal

  enum Action {
    case typingEmail(String)
    case typingPassword(String)
    case typingFullName(String)
    case typingUserName(String)
    case isAllInputValid(Bool)
  }

  enum Mutation {
    case setEmail(String)
    case setPassword(String)
    case setFullName(String)
    case setUserName(String)
    case setIsAllInputValid(Bool)
  }

  typealias State = RegisterDisplayModel.FormState

  var initialState: State = .init()
}

// MARK: Reactor

extension FormRegisterReactor: Reactor {

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .typingEmail(email):
      return .just(.setEmail(email))
    case let .typingPassword(password):
      return .just(.setPassword(password))
    case let .typingFullName(fullName):
      return .just(.setFullName(fullName))
    case let .typingUserName(userName):
      return .just(.setUserName(userName))
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
    case let .setFullName(fullName):
      newState.fullName = fullName
    case let .setUserName(userName):
      newState.userName = userName
    case let .setIsAllInputValid(isValid):
      newState.isAllInputValid = isValid
    }

    return newState
  }
}
