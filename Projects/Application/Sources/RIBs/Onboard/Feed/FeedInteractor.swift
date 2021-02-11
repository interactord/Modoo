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

final class FeedInteractor: PresentableInteractor<FeedPresentable>, FeedInteractable, FeedPresentableListener {

  // MARK: Lifecycle

  override init(presenter: FeedPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  deinit {
    print("FeedInteractor deinit...")
  }

  // MARK: Internal

  weak var router: FeedRouting?
  weak var listener: FeedListener?

}
