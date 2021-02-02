import RIBs
import RxSwift

// MARK: - RegisterRouting

protocol RegisterRouting: ViewableRouting {
}

// MARK: - RegisterPresentable

protocol RegisterPresentable: Presentable {
  var listener: RegisterPresentableListener? { get set }
}

// MARK: - RegisterListener

protocol RegisterListener: AnyObject {
}

// MARK: - RegisterInteractor

final class RegisterInteractor: PresentableInteractor<RegisterPresentable>, RegisterInteractable {

  // MARK: Lifecycle

  override init(presenter: RegisterPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  // MARK: Internal

  weak var router: RegisterRouting?
  weak var listener: RegisterListener?

}

// MARK: RegisterPresentableListener

extension RegisterInteractor: RegisterPresentableListener {
}
