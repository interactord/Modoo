import ReactorKit
import RIBs
import RxSwift

// MARK: - RegisterRouting

protocol RegisterRouting: ViewableRouting {}

// MARK: - RegisterPresentable

protocol RegisterPresentable: Presentable {
  var listener: RegisterPresentableListener? { get set }
}

// MARK: - RegisterListener

protocol RegisterListener: AnyObject {
  func routeToLogin()
  func routeToOnboard()
}

// MARK: - RegisterInteractor

final class RegisterInteractor: PresentableInteractor<RegisterPresentable>, RegisterInteractable {

  // MARK: Lifecycle

  init(
    presenter: RegisterPresentable,
    initialState: RegisterPresentableState)
  {
    self.initialState = initialState
    super.init(presenter: presenter)
    presenter.listener = self
  }

  deinit {
    print("RegisterInteractor deinit...")
  }

  // MARK: Internal

  enum Mutation: Equatable {
    case requestSignUp
    case login
  }

  typealias Action = RegisterPresentableAction
  typealias State = RegisterPresentableState

  weak var router: RegisterRouting?
  weak var listener: RegisterListener?

  let initialState: RegisterPresentableState

}

// MARK: RegisterPresentableListener, Reactor

extension RegisterInteractor: RegisterPresentableListener, Reactor {

  // MARK: Internal

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .signUp:
      return mutatignRequestSignUp()
    case .login:
      return .just(.login)
    }
  }

  func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
    mutation
      .withUnretained(self)
      .flatMap{ owner, mutation -> Observable<Mutation> in
        switch mutation {
        case .requestSignUp:
          return owner.transformingRequestSignUp()
        case .login:
          return owner.transFormingLogin()
        }
      }
  }

  // MARK: Private

  private func mutatignRequestSignUp() -> Observable<Mutation> {
    .just(.requestSignUp)
  }

  private func transformingRequestSignUp() -> Observable<Mutation> {
    listener?.routeToOnboard()
    return .empty()
  }

  private func transFormingLogin() -> Observable<Mutation> {
    listener?.routeToLogin()
    return .empty()
  }
}
