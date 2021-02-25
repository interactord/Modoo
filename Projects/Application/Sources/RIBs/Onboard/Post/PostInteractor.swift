import RIBs
import RxSwift

// MARK: - PostRouting

protocol PostRouting: ViewableRouting {
}

// MARK: - PostPresentable

protocol PostPresentable: Presentable {
  var listener: PostPresentableListener? { get set }
}

// MARK: - PostListener

protocol PostListener: AnyObject {
}

// MARK: - PostInteractor

final class PostInteractor: PresentableInteractor<PostPresentable>, PostInteractable, PostPresentableListener {

  // MARK: Lifecycle

  override init(presenter: PostPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  deinit {
    print("PostInteractor deinit...")
  }

  // MARK: Internal

  weak var router: PostRouting?
  weak var listener: PostListener?

}
