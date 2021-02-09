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
    initialState: RegisterDisplayModel.State)
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
    case setPhoto(UIImage?)
    case setEmail(String)
    case setPassword(String)
    case setFullName(String)
    case setUserName(String)
  }

  typealias Action = RegisterPresentableAction
  typealias State = RegisterDisplayModel.State

  weak var router: RegisterRouting?
  weak var listener: RegisterListener?

  let initialState: State

}

// MARK: RegisterPresentableListener, Reactor

extension RegisterInteractor: RegisterPresentableListener, Reactor {

  // MARK: Internal

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .signUp:
      return mutatingRequestSignUp()
    case .login:
      return .just(.login)
    case  let .photo(image):
      return .just(.setPhoto(image))
    case let .email(text):
      return .just(.setEmail(text))
    case let .password(text):
      return .just(.setPassword(text))
    case let .fullName(text):
      return .just(.setFullName(text))
    case let .userName(text):
      return .just(.setUserName(text))
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
        default:
          return .just(mutation)
        }
      }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state

    switch mutation {
    case  let .setPhoto(image):
      newState.photo = image
    case let .setEmail(text):
      newState.email = text
    case let .setPassword(text):
      newState.password = text
    case let .setFullName(text):
      newState.fullName = text
    case let .setUserName(text):
      newState.userName = text
    default:
      break
    }

    return newState
  }

  // MARK: Private

  private func mutatingRequestSignUp() -> Observable<Mutation> {
    .just(.requestSignUp)
  }

  private func transformingRequestSignUp() -> Observable<Mutation> {
    print(currentState)
    listener?.routeToOnboard()
    return .empty()
  }

  private func transFormingLogin() -> Observable<Mutation> {
    listener?.routeToLogin()
    return .empty()
  }
}
