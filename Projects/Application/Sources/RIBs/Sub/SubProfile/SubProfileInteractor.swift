import ReactorKit
import RIBs
import RxSwift

// MARK: - SubProfileRouting

protocol SubProfileRouting: ViewableRouting {
}

// MARK: - SubProfilePresentable

protocol SubProfilePresentable: Presentable {
  var listener: SubProfilePresentableListener? { get set }
}

// MARK: - SubProfileListener

protocol SubProfileListener: AnyObject {
  func routeToBackFromSubProfile()
  func routeToSubFeed(model: ProfileContentSectionModel.Cell)
}

// MARK: - SubProfileInteractor

final class SubProfileInteractor: PresentableInteractor<SubProfilePresentable>, SubProfileInteractable {

  // MARK: Lifecycle

  init(
    presenter: SubProfilePresentable,
    initialState: SubProfileDisplayModel.State,
    userUseCase: UserUseCase,
    postUseCase: PostUseCase,
    uid: String)
  {
    defer { presenter.listener = self }
    self.initialState = initialState
    self.uid = uid
    self.userUseCase = userUseCase
    self.postUseCase = postUseCase
    super.init(presenter: presenter)
  }

  deinit {
    print("SubProfileInteractor deinit...")
  }

  // MARK: Internal

  weak var router: SubProfileRouting?
  weak var listener: SubProfileListener?

  var initialState: SubProfileDisplayModel.State

  // MARK: Private

  private let uid: String
  private let userUseCase: UserUseCase
  private let postUseCase: PostUseCase

}

// MARK: SubProfilePresentableListener, Reactor

extension SubProfileInteractor: SubProfilePresentableListener, Reactor {

  // MARK: Internal

  typealias Action = SubProfileDisplayModel.Action
  typealias State = SubProfileDisplayModel.State
  typealias Mutation = SubProfileDisplayModel.Mutation

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .load:
      return mutatingLoad(uid: uid)
    case let .loading(isLoading):
      return .just(.setLoading(isLoading))
    case .back:
      return mutatingBack()
    case .follow:
      return mutatingFollow(uid: uid)
    case .unFollow:
      return mutatingUnFollow(uid: uid)
    case let .loadPost(itemModel):
      return mutatingLoadPost(model: itemModel)
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state

    switch mutation {
    case let .setUserProfile(headerItem):
      newState.informationSectionItemModel = .init(headerItem: headerItem, original: state.informationSectionItemModel)
    case let .setPosts(cellItems):
      newState.contentsSectionItemModel = .init(cellItems: cellItems, original: state.contentsSectionItemModel)
    case let .setLoading(isLoading):
      newState.isLoading = isLoading
    case let .setError(message):
      newState.errorMessage = message
    case let .setFollow(isFollow):
      var headerItem = newState.informationSectionItemModel.headerItem
      headerItem.isFollowed = isFollow
      newState.informationSectionItemModel = .init(headerItem: headerItem, original: state.informationSectionItemModel)
    }

    return newState
  }

  // MARK: Private

  private func mutatingLoad(uid: String) -> Observable<Mutation> {
    guard !currentState.isLoading else { return .empty() }

    let startLoading = Observable.just(Mutation.setLoading(true))
    let stopLoading = Observable.just(Mutation.setLoading(false))
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

  private func mutatingBack() -> Observable<Mutation> {
    listener?.routeToBackFromSubProfile()
    return .empty()
  }

  private func mutatingFollow(uid: String) -> Observable<Mutation> {
    guard !currentState.isLoading else { return .empty() }

    let startLoading = Observable.just(Mutation.setLoading(true))
    let stopLoading = Observable.just(Mutation.setLoading(false))
    let useCaseStream = userUseCase.follow(to: uid).flatMap { _ -> Observable<Mutation> in
      .just(.setFollow(true))
    }
    .catch { .just(.setError($0.localizedDescription)) }

    return Observable.concat([startLoading, useCaseStream, stopLoading])
  }

  private func mutatingUnFollow(uid: String) -> Observable<Mutation> {
    guard !currentState.isLoading else { return .empty() }

    let startLoading = Observable.just(Mutation.setLoading(true))
    let stopLoading = Observable.just(Mutation.setLoading(false))
    let useCaseStream = userUseCase.unFollow(to: uid).flatMap { _ -> Observable<Mutation> in
      .just(.setFollow(false))
    }
    .catch { .just(.setError($0.localizedDescription)) }

    return Observable.concat([startLoading, useCaseStream, stopLoading])
  }

  private func mutatingLoadPost(model: ProfileContentSectionModel.Cell) -> Observable<Mutation> {
    listener?.routeToSubFeed(model: model)
    return .empty()
  }

}
