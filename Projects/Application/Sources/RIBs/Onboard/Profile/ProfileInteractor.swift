import ReactorKit
import RIBs
import RxSwift

// MARK: - ProfileRouting

protocol ProfileRouting: ViewableRouting {
}

// MARK: - ProfilePresentable

protocol ProfilePresentable: Presentable {
  var listener: ProfilePresentableListener? { get set }
}

// MARK: - ProfileListener

protocol ProfileListener: AnyObject {
}

// MARK: - ProfileInteractor

final class ProfileInteractor: PresentableInteractor<ProfilePresentable>, ProfileInteractable {

  // MARK: Lifecycle

  init(
    presenter: ProfilePresentable,
    initialState: ProfileDisplayModel.State,
    userUseCase: UserUseCase)
  {
    defer { presenter.listener = self }
    self.initialState = initialState
    self.userUseCase = userUseCase
    super.init(presenter: presenter)
  }

  deinit {
    print("ProfileInteractor deinit...")
  }

  // MARK: Internal

  typealias Action = ProfilePresentableAction
  typealias State = ProfileDisplayModel.State

  enum Mutation: Equatable {
    case setUserProfile(ProfileDisplayModel.InformationDisplayModel)
    case setError(String)
    case setLoading(Bool)
  }

  weak var router: ProfileRouting?
  weak var listener: ProfileListener?

  let initialState: State
  let userUseCase: UserUseCase

}

// MARK: ProfilePresentableListener, Reactor

extension ProfileInteractor: ProfilePresentableListener, Reactor {

  // MARK: Internal

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .load:
      return mutatingLoad()
    case let .loading(isLoading):
      return .just(.setLoading(isLoading))
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state

    switch mutation {
    case let .setUserProfile(informationDisplayModel):
      let sectionID = state.informationSectionModel.sectionID
      newState.informationSectionModel = .init(sectionID: sectionID, displayModel: informationDisplayModel)
    case  let .setLoading(isLoading):
      newState.isLoading = isLoading
    case  let .setError(message):
      newState.errorMessage = message
    }

    return newState
  }

  // MARK: Private

  private func mutatingLoad() -> Observable<Mutation> {
    guard !currentState.isLoading else { return .empty() }

    let startLoading = Observable.just(Mutation.setLoading(true))
    let stopLoading = Observable.just(Mutation.setLoading(false))
    let useCaseStream = userUseCase.fetchUser().flatMap { repository -> Observable<Mutation> in
      let model = ProfileDisplayModel.InformationDisplayModel(
        userName: repository.username,
        avatarImageURL: repository.profileImageURL,
        postCount: "0",
        followingCount: "0",
        followerCount: "0",
        bioDescription: "")
      return .just(.setUserProfile(model))
    }
    .catch { .just(.setError($0.localizedDescription)) }

    return Observable.concat([startLoading, useCaseStream, stopLoading])
  }
}
