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
    initialState: LoginDisplayModel.State,
    authenticationUseCase: AuthenticationUseCase)
  {
    defer { presenter.listener = self }
    self.initialState = initialState
    self.authenticationUseCase = authenticationUseCase
    super.init(presenter: presenter)
  }

  deinit {
    print("LoginInteractor deinit...")
  }

  // MARK: Internal

  typealias Action = LoginPresentableAction
  typealias State = LoginDisplayModel.State

  enum Mutation: Equatable {
    case setLoginState(FormLoginReactor.State)
    case setError(String)
    case setLoading(Bool)
  }

  weak var router: LoginRouting?
  weak var listener: LoginListener?

  let initialState: State
  let authenticationUseCase: AuthenticationUseCase

}

// MARK: LoginPresentableListener, Reactor

extension LoginInteractor: LoginPresentableListener, Reactor {

  // MARK: Internal

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .loginState(state):
      return .just(.setLoginState(state))
    case .login:
      return  mutatingRequestLogin()
    case .register:
      return  mutatingRegister()
    case let .loading(isLoading):
      return .just(.setLoading(isLoading))
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state

    switch mutation {
    case let .setLoginState(state):
      newState.formState = state
    case let .setLoading(isLoading):
      newState.isLoading = isLoading
    case  let .setError(message):
      newState.errorMessage = message
    }

    return newState
  }

  // MARK: Private

  private func mutatingRegister() -> Observable<Mutation> {
    listener?.routeToRegister()

    return .empty()
  }

  private func mutatingRequestLogin() -> Observable<Mutation> {
    guard !currentState.isLoading else { return .empty() }

    let startLoading = Observable.just(Mutation.setLoading(true))
    let stopLoading = Observable.just(Mutation.setLoading(false))
    let useCaseStream = authenticationUseCase
      .login(domain: currentState)
      .withUnretained(self)
      .observe(on: MainScheduler.asyncInstance)
      .flatMap { owner, _ -> Observable<Mutation> in
        owner.listener?.routeToOnboard()
        return .empty()
      }
      .catch { .just(.setError($0.localizedDescription)) }

    return Observable.concat([startLoading, useCaseStream, stopLoading])
  }

}
