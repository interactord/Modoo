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
  func routeToSubFeed()
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
    case let .loadPost(itemModel):
      return mutatingLoadPost(model: itemModel)
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
    let useCaseStream = Observable.zip(
      userUseCase.fetchUser(uid: uid),
      userUseCase.fetchUserSocial(uid: uid),
      postUseCase.fetchPosts(uid: uid))
      .flatMap { userModel, socialModel, postModels -> Observable<Mutation> in
        let infomationModel = ProfileDisplayModel.InformationSectionItem(
          userRepositoryModel: userModel,
          socialRepositoryModel: socialModel,
          postCount: postModels.count)
        let postItems = postModels.map{ ProfileDisplayModel.MediaContentSectionItem.CellItem(id: $0.id, imageURL: $0.imageURL) }
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

  private func mutatingLoadPost(model: ProfileDisplayModel.MediaContentSectionItem.CellItem) -> Observable<Mutation> {
    listener?.routeToSubFeed()
    return .empty()
  }
}
