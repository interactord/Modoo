import RIBs
import RxSwift

// MARK: - SubFeedRouting

protocol SubFeedRouting: ViewableRouting {
}

// MARK: - SubFeedPresentable

protocol SubFeedPresentable: Presentable {
  var listener: SubFeedPresentableListener? { get set }
}

// MARK: - SubFeedListener

protocol SubFeedListener: AnyObject {
}

// MARK: - SubFeedInteractor

final class SubFeedInteractor: PresentableInteractor<SubFeedPresentable>, SubFeedInteractable, SubFeedPresentableListener {

  // MARK: Lifecycle

  override init(presenter: SubFeedPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  deinit {
    print("SubFeedInteractor deinit...")
  }

  // MARK: Internal

  weak var router: SubFeedRouting?
  weak var listener: SubFeedListener?

}
