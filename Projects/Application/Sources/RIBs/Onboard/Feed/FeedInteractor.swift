import ReactorKit
import RIBs
import RxSwift

// MARK: - FeedRouting

protocol FeedRouting: ViewableRouting {
}

// MARK: - FeedPresentable

protocol FeedPresentable: Presentable {
  var listener: FeedPresentableListener? { get set }
}

// MARK: - FeedListener

protocol FeedListener: AnyObject {
}

// MARK: - FeedInteractor

final class FeedInteractor: PresentableInteractor<FeedPresentable>, FeedInteractable {

  // MARK: Lifecycle

  init(
    presenter: FeedPresentable,
    initialState: FeedDisplayModel.State)
  {
    self.initialState = initialState
    defer { presenter.listener = self }
    super.init(presenter: presenter)
  }

  deinit {
    print("FeedInteractor deinit...")
  }

  // MARK: Internal

  typealias Action = FeedPresentableAction
  typealias State = FeedDisplayModel.State

  enum Mutation: Equatable {
    case setPostContentSectionItem(FeedDisplayModel.PostContentSectionItem)
  }

  weak var router: FeedRouting?
  weak var listener: FeedListener?

  var initialState: FeedDisplayModel.State

}

// MARK: FeedPresentableListener, Reactor

extension FeedInteractor: FeedPresentableListener, Reactor {

  // MARK: Internal

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .load:
      return mutatingLoad()
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state

    switch mutation {
    case let .setPostContentSectionItem(item):
      let sectionID = state.postContentSectionModel.sectionID
      newState.postContentSectionModel = .init(sectionID: sectionID, sectionItem: item)
    }

    return newState
  }

  // MARK: Private

  private func mutatingLoad() -> Observable<Mutation> {
    .just(.setPostContentSectionItem(.init(postRepositoryModels: [])))
  }
}
