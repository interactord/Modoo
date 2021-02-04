import RIBs
import RxSwift

// MARK: - AuthenticationRouting

protocol AuthenticationRouting: ViewableRouting {
  func cleanupViews()
  func routeToLogin()
  func routeToRegister()
}

// MARK: - AuthenticationPresentable

protocol AuthenticationPresentable: Presentable {
  var listener: AuthenticationPresentableListener? { get set }
}

// MARK: - AuthenticationListener

protocol AuthenticationListener: AnyObject {
  func routeToOnboard()
}

// MARK: - AuthenticationInteractor

final class AuthenticationInteractor: PresentableInteractor<AuthenticationPresentable>, AuthenticationInteractable {

  // MARK: Lifecycle

  override init(presenter: AuthenticationPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  deinit {
    print("AuthenticationInteractor deinit")
  }

  // MARK: Internal

  weak var router: AuthenticationRouting?
  weak var listener: AuthenticationListener?

  func routeToLogin() {
    router?.routeToLogin()
  }

  func routeToRegister() {
    router?.routeToRegister()
  }

  func routeToOnboard() {
    listener?.routeToOnboard()
  }

}

// MARK: AuthenticationPresentableListener

extension AuthenticationInteractor: AuthenticationPresentableListener {
}
