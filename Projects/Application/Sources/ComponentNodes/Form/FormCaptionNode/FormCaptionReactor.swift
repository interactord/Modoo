import ReactorKit
import RxSwift

// MARK: - FormCaptionReactor

final class FormCaptionReactor {

  // MARK: Lifecycle

  init(scope: Scope) {
    self.scope = scope
  }

  deinit {
    print("FormCaptionReactor deinit...")
  }

  // MARK: Internal

  struct Scope {
    let placeholderText: String
    let minCount: Int
    let maxCount: Int
  }

  enum ValidType {
    case valid
    case invalid
  }

  enum Action: Equatable {
    case typingText(String)
  }

  enum Mutation {
    case setText(String)
  }

  struct State {
    var text = ""
    var currentTextRange = 0
    var isValid = false
  }

  var initialState: State = .init()
  let scope: Scope
}

// MARK: Reactor

extension FormCaptionReactor: Reactor {

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .typingText(text):
      return .just(.setText(text))
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state

    switch mutation {
    case let .setText(text):
      newState.text = text
      newState.currentTextRange = text.count
      newState.isValid = text.count >= scope.minCount && text.count <= scope.maxCount
    }

    return newState
  }
}
