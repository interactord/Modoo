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
}

// MARK: - SubProfileInteractor

final class SubProfileInteractor: PresentableInteractor<SubProfilePresentable>, SubProfileInteractable, SubProfilePresentableListener {

  // MARK: Lifecycle

  override init(presenter: SubProfilePresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  deinit {
    print("SubProfileInteractor deinit...")
  }

  // MARK: Internal

  weak var router: SubProfileRouting?
  weak var listener: SubProfileListener?

}
