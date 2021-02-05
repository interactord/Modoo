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
    initialState: LoginPresentableState)
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
  typealias State = LoginPresentableState

  enum Mutation: Equatable {
    case requestLogin
    case register
  }

  weak var router: LoginRouting?
  weak var listener: LoginListener?

  let initialState: LoginPresentableState

}

// MARK: LoginPresentableListener, Reactor

extension LoginInteractor: LoginPresentableListener, Reactor {

  // MARK: Internal

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .login:
      return  mutatingRequestLogin()
    case .register:
      return  .just(.register)
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
        }
      }
  }

  // MARK: Private

  private func mutatingRequestLogin() -> Observable<Mutation> {
    .just(.requestLogin)
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
