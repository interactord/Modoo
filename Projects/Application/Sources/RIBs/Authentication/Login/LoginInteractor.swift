import RIBs
import RxSwift

// MARK: - LoginRouting

protocol LoginRouting: ViewableRouting {}

// MARK: - LoginPresentable

protocol LoginPresentable: Presentable {
  var listener: LoginPresentableListener? { get set }
}

// MARK: - LoginListener

protocol LoginListener: AnyObject {
  func didLogin()
}

// MARK: - LoginInteractor

final class LoginInteractor: PresentableInteractor<LoginPresentable>, LoginInteractable {

  // MARK: Lifecycle

  override init(presenter: LoginPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  // MARK: Internal

  weak var router: LoginRouting?
  weak var listener: LoginListener?

}

// MARK: LoginPresentableListener

extension LoginInteractor: LoginPresentableListener {
  func login() {
    listener?.didLogin()
  }
}
