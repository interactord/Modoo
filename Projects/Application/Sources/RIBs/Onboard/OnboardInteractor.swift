import ReactorKit
import RIBs
import RxSwift

// MARK: - OnboardRouting

protocol OnboardRouting: ViewableRouting {
  func setOnceViewControllers()
  func routeToPost(image: UIImage)
  func routeToClose()
  func routeToComment(item: FeedContentSectionModel.Cell)
  func routeToBackFromComment()
}

// MARK: - OnboardPresentable

protocol OnboardPresentable: Presentable {
  var listener: OnboardPresentableListener? { get set }
}

// MARK: - OnboardListener

protocol OnboardListener: AnyObject {
  func routeToAuthentication()
}

// MARK: - OnboardInteractor

final class OnboardInteractor: PresentableInteractor<OnboardPresentable> {

  // MARK: Lifecycle

  init(
    presenter: OnboardPresentable,
    initialState: OnboardDisplayModel.State)
  {
    self.initialState = initialState
    defer { presenter.listener = self }
    super.init(presenter: presenter)
  }

  deinit {
    print("OnboardInteractor deinit...")
  }

  // MARK: Internal

  typealias Action = OnboardDisplayModel.Action
  typealias State = OnboardDisplayModel.State

  enum Mutation: Equatable {
  }

  weak var router: OnboardRouting?
  weak var listener: OnboardListener?
  var initialState: OnboardDisplayModel.State

  override func willResignActive() {
    super.willResignActive()
    router?.setOnceViewControllers()
  }

}

// MARK: OnboardPresentableListener, Reactor

extension OnboardInteractor: OnboardPresentableListener, Reactor {

  // MARK: Internal

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .postImage(image):
      return mutatingPostImage(image: image)
    }
  }

  // MARK: Private

  private func mutatingPostImage(image: UIImage) -> Observable<Mutation> {
    router?.routeToPost(image: image)
    return .empty()
  }
}

// MARK: OnboardInteractable

extension OnboardInteractor: OnboardInteractable {
  func routeToAuthentication() {
    listener?.routeToAuthentication()
  }

  func routeToClose() {
    router?.routeToClose()
  }

  func routeToComment(item: FeedContentSectionModel.Cell) {
    router?.routeToComment(item: item)
  }

  func routeToBackFromComment() {
    router?.routeToBackFromComment()
  }
}
