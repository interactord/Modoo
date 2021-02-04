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
  func routeToOnboard()
  func routeToRegister()
}

// MARK: - LoginInteractor

final class LoginInteractor: PresentableInteractor<LoginPresentable>, LoginInteractable {

  // MARK: Lifecycle

  override init(presenter: LoginPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  deinit {
    print("LoginInteractor deinit...")
  }

  // MARK: Internal

  weak var router: LoginRouting?
  weak var listener: LoginListener?

}

// MARK: LoginPresentableListener

extension LoginInteractor: LoginPresentableListener {
  func loginAction() {
    listener?.routeToOnboard()
  }

  func registerAction() {
    listener?.routeToRegister()
  }
}
