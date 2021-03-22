import RIBs
import RxSwift

// MARK: - CommentRouting

protocol CommentRouting: ViewableRouting {
}

// MARK: - CommentPresentable

protocol CommentPresentable: Presentable {
  var listener: CommentPresentableListener? { get set }
}

// MARK: - CommentListener

protocol CommentListener: AnyObject {
}

// MARK: - CommentInteractor

final class CommentInteractor: PresentableInteractor<CommentPresentable>, CommentInteractable, CommentPresentableListener {

  // MARK: Lifecycle

  override init(presenter: CommentPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  deinit {
    print("CommentInteractor deinit...")
  }

  // MARK: Internal

  weak var router: CommentRouting?
  weak var listener: CommentListener?

}
