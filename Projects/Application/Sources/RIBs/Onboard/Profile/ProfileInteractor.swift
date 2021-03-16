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
  func routeToAuthentication()
}

// MARK: - ProfileInteractor

final class ProfileInteractor: PresentableInteractor<ProfilePresentable>, ProfileInteractable {

  // MARK: Lifecycle

  init(
    presenter: ProfilePresentable,
    initialState: ProfileDisplayModel.State,
    userUseCase: UserUseCase,
    postUseCase: PostUseCase)
  {
    defer { presenter.listener = self }
    self.initialState = initialState
    self.userUseCase = userUseCase
    self.postUseCase = postUseCase
    super.init(presenter: presenter)
  }

  deinit {
    print("ProfileInteractor deinit...")
  }

  // MARK: Internal

  typealias Action = ProfilePresentableAction
  typealias State = ProfileDisplayModel.State

  enum Mutation: Equatable {
    case setUserProfile(ProfileDisplayModel.InformationSectionItem)
    case setPosts([ProfileDisplayModel.MediaContentSectionItem.CellItem])
    case setError(String)
    case setLoading(Bool)
  }

  weak var router: ProfileRouting?
  weak var listener: ProfileListener?

  let initialState: State
  let userUseCase: UserUseCase
  let postUseCase: PostUseCase

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
    case .logout:
      return mutatingLogout()
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state

    switch mutation {
    case let .setUserProfile(informationSectionItem):
      let sectionID = state.informationSectionItemModel.sectionID
      newState.informationSectionItemModel = .init(sectionID: sectionID, sectionItem: informationSectionItem)
    case let .setPosts(cellItems):
      let sectionID = state.contentsSectionItemModel.sectionID
      let newSectionItem = ProfileDisplayModel.MediaContentSectionItem(headerItem: state.contentsSectionItemModel.headerItem, cellItems: cellItems)
      newState.contentsSectionItemModel = .init(sectionID: sectionID, sectionItem: newSectionItem)
    case let .setLoading(isLoading):
      newState.isLoading = isLoading
    case let .setError(message):
      newState.errorMessage = message
    }

    return newState
  }

  // MARK: Private

  private func mutatingLoad() -> Observable<Mutation> {
    guard !currentState.isLoading else { return .empty() }

    let startLoading = Observable.just(Mutation.setLoading(true))
    let stopLoading = Observable.just(Mutation.setLoading(false))
    let uid = userUseCase.authenticationToken
    let userUseCaseStream = Observable.zip(
      userUseCase.fetchUser(uid: uid),
      userUseCase.fetchUserSocial(uid: uid))
      .flatMap { userModel, socialModel -> Observable<Mutation> in
        let model = ProfileDisplayModel.InformationSectionItem(userRepositoryModel: userModel, socialRepositoryModel: socialModel)
        return .just(.setUserProfile(model))
      }
      .catch { .just(.setError($0.localizedDescription)) }
    let postUseCaseStream = postUseCase
      .fetchPosts(uid: uid).flatMap { postReposityModel -> Observable<Mutation> in
        let models = postReposityModel.map{ ProfileDisplayModel.MediaContentSectionItem.CellItem(id: $0.id, imageURL: $0.imageURL) }
        return .just(.setPosts(models))
      }
      .catch { .just(.setError($0.localizedDescription)) }

    return Observable.concat([startLoading, userUseCaseStream, postUseCaseStream, stopLoading])
  }

  private func mutatingLogout() -> Observable<Mutation> {
    listener?.routeToAuthentication()

    return .empty()
  }
}
