import ReactorKit
import RIBs
import RxSwift

// MARK: - LoginRouting

protocol LoginRouting: ViewableRouting {}

// MARK: - LoginPresentable

protocol LoginPresentable: Presentable {
  var listener: LoginPresentableListener? { get set }
}

// MARK: - LoginListener

protocol LoginListener: AnyObject {
  func routeToOnboard()
  func routeToRegister()
}

// MARK: - LoginInteractor

final class LoginInteractor: PresentableInteractor<LoginPresentable>, LoginInteractable
{

  // MARK: Lifecycle

  init(
    presenter: LoginPresentable,
    initialState: LoginDisplayModel.State)
  {
    self.initialState = initialState
    super.init(presenter: presenter)
    presenter.listener = self
  }

  deinit {
    print("LoginInteractor deinit...")
  }

  // MARK: Internal

  typealias Action = LoginPresentableAction
  typealias State = LoginDisplayModel.State

  enum Mutation: Equatable {
    case requestLogin
    case register
    case setEmail(String)
    case setPassword(String)
  }

  weak var router: LoginRouting?
  weak var listener: LoginListener?

  let initialState: State

}

// MARK: LoginPresentableListener, Reactor

extension LoginInteractor: LoginPresentableListener, Reactor {

  // MARK: Internal

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state

    switch mutation {
    case let .setEmail(text):
      newState.email = text
    case let .setPassword(text):
      newState.password = text
    default:
      break
    }

    return newState
  }

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .login:
      return  mutatingRequestLogin()
    case .register:
      return  .just(.register)
    case let .email(text):
      return .just(.setEmail(text))
    case let .password(text):
      return .just(.setPassword(text))
    }
  }

  func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
    mutation
      .withUnretained(self)
      .flatMap{ owner, mutation -> Observable<Mutation> in
        switch mutation {
        case .requestLogin:
          return owner.transformingRequestLogin()
        case .register:
          return owner.transformingRegister()
        default:
          return .just(mutation)
        }
      }
  }

  // MARK: Private

  private func mutatingRequestLogin() -> Observable<Mutation> {
    print(currentState)
    return .just(.requestLogin)
  }

  private func transformingRequestLogin() -> Observable<Mutation> {
    listener?.routeToOnboard()
    return .empty()
  }

  private func transformingRegister() -> Observable<Mutation> {
    listener?.routeToRegister()
    return .empty()
  }
}
