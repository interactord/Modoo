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
    initialState: RegisterDisplayModel.State,
    authenticationUseCase: AuthenticationUseCase)
  {
    defer { presenter.listener = self }
    self.initialState = initialState
    self.authenticationUseCase = authenticationUseCase
    super.init(presenter: presenter)
  }

  deinit {
    print("RegisterInteractor deinit...")
  }

  // MARK: Internal

  enum Mutation: Equatable {
    case setPhoto(UIImage?)
    case setFormState(RegisterDisplayModel.FormState)
    case setLoading(Bool)
    case setError(String)
  }

  typealias Action = RegisterPresentableAction
  typealias State = RegisterDisplayModel.State

  weak var router: RegisterRouting?
  weak var listener: RegisterListener?

  let initialState: State
  let authenticationUseCase: AuthenticationUseCase

}

// MARK: RegisterPresentableListener, Reactor

extension RegisterInteractor: RegisterPresentableListener, Reactor {

  // MARK: Internal

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .login:
      return mutatingLogin()
    case .signUp:
      return mutatingRequestSignUp()
    case  let .photo(image):
      return .just(.setPhoto(image))
    case let .registerFormState(formState):
      return .just(.setFormState(formState))
    case let .loading(isLoading):
      return .just(.setLoading(isLoading))
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state

    switch mutation {
    case  let .setPhoto(image):
      newState.photo = image
    case let .setFormState(formState):
      newState.formState = formState
    case let .setLoading(isLoading):
      newState.isLoading = isLoading
    case let .setError(message):
      newState.errorMessage = message
    }

    return newState
  }

  // MARK: Private

  private func mutatingLogin() -> Observable<Mutation> {
    listener?.routeToLogin()
    return .empty()
  }

  private func mutatingRequestSignUp() -> Observable<Mutation> {
    guard !currentState.isLoading else { return .empty() }

    let startLoading = Observable.just(Mutation.setLoading(true))
    let stopLoading = Observable.just(Mutation.setLoading(false))
    let useCaseStream = authenticationUseCase
      .register(domain: currentState)
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
