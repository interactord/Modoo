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
  func routeToSubFeed(model: ProfileContentSectionModel.Cell)
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

  weak var router: ProfileRouting?
  weak var listener: ProfileListener?

  let initialState: State
  let userUseCase: UserUseCase
  let postUseCase: PostUseCase

}

// MARK: ProfilePresentableListener, Reactor

extension ProfileInteractor: ProfilePresentableListener, Reactor {

  // MARK: Internal

  typealias Action = ProfileDisplayModel.Action
  typealias State = ProfileDisplayModel.State
  typealias Mutation = ProfileDisplayModel.Mutation

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .load:
      return mutatingLoad()
    case let .loading(isLoading):
      return .just(.setLoading(isLoading))
    case .logout:
      return mutatingLogout()
    case let .loadPost(itemModel):
      return mutatingLoadPost(model: itemModel)
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state

    switch mutation {
    case let .setUserProfile(informationSectionItem):
      newState.informationSectionItemModel = .init(headerItem: informationSectionItem, original: state.informationSectionItemModel)
    case let .setPosts(cellItems):
      newState.contentsSectionItemModel = .init(cellItems: cellItems, original: currentState.contentsSectionItemModel)
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
    let useCaseStream = Observable.zip(
      userUseCase.fetchUser(uid: uid),
      userUseCase.fetchUserSocial(uid: uid),
      postUseCase.fetchPosts(uid: uid))
      .flatMap { userModel, socialModel, postModels -> Observable<Mutation> in
        let infomationModel = UserInformationSectionModel.Header(
          userRepositoryModel: userModel,
          socialRepositoryModel: socialModel,
          postCount: postModels.count)
        let postItems = postModels.map{ ProfileContentSectionModel.Cell(uid: uid, postRepositoryModel: $0) }
        return .concat([
          .just(.setUserProfile(infomationModel)),
          .just(.setPosts(postItems)),
        ])
      }
      .catch { .just(.setError($0.localizedDescription)) }

    return Observable.concat([startLoading, useCaseStream, stopLoading])
  }

  private func mutatingLogout() -> Observable<Mutation> {
    listener?.routeToAuthentication()
    return .empty()
  }

  private func mutatingLoadPost(model: ProfileContentSectionModel.Cell) -> Observable<Mutation> {
    listener?.routeToSubFeed(model: model)
    return .empty()
  }
}
