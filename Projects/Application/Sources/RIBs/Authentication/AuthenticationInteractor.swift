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
  func routeToLoggedIn()
}

// MARK: - AuthenticationInteractor

final class AuthenticationInteractor: PresentableInteractor<AuthenticationPresentable>, AuthenticationInteractable, AuthenticationPresentableListener {

  // MARK: Lifecycle

  override init(presenter: AuthenticationPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
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

  func routeToLoggedIn() {
    listener?.routeToLoggedIn()
  }

}
