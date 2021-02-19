import ReactorKit
import RxSwift

// MARK: - FormTextInputReactor

final class FormTextInputReactor {

  // MARK: Lifecycle

  deinit {
    print("FormTextInputNodeReactor deinit..")
  }

  // MARK: Internal

  enum Scope: Equatable {
    case email
    case password
    case plain(placeholderString: String)

    // MARK: Internal

    var isSecureTextEntity: Bool {
      self == .password
    }

    var clearsOnInsertion: Bool {
      self == .password
    }

    var placeholderString: String {
      switch self {
      case .email:
        return "Email"
      case .password:
        return "password"
      case let .plain(placeholderString):
        return placeholderString
      }
    }
  }

  enum Action {
    case editingChanged(Scope?, String?)
  }

  enum Mutation {
    case setStatus(Scope?, String?)
  }

  struct State {
    var state: TextInputNodeViewableState = .wrong
  }

  struct Const {
    static let passwordMinimumValidCount = 6
    static let plainMinimumValidCount = 3
  }

  let initialState = State()

}

// MARK: Reactor

extension FormTextInputReactor: Reactor {
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .editingChanged(scope, text):
      return Observable.just(.setStatus(scope, text))
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state

    switch mutation {
    case let .setStatus(scope, text):
      guard let scope = scope, let text = text else { return state }

      if text.isEmpty {
        newState.state = .wrong

        return newState
      }

      switch scope {
      case .email:
        newState.state = text.isValidEmail() ? .valid: .wrong
      case .password:
        newState.state = text.count > Const.passwordMinimumValidCount ? .valid : .wrong
      case .plain:
        newState.state = text.count > Const.plainMinimumValidCount ? .valid : .wrong
      }
    }

    return newState
  }

}
