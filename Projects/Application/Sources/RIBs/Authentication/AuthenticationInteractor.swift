import RIBs
import RxSwift

// MARK: - AuthenticationRouting

protocol AuthenticationRouting: ViewableRouting {
  func cleanupViews()
  func routeLogin()
}

// MARK: - AuthenticationPresentable

protocol AuthenticationPresentable: Presentable {
  var listener: AuthenticationPresentableListener? { get set }
}

// MARK: - AuthenticationListener

protocol AuthenticationListener: AnyObject {
  func routeToLogin()
}

// MARK: - AuthenticationInteractor

final class AuthenticationInteractor: PresentableInteractor<AuthenticationPresentable>, AuthenticationInteractable {

  // MARK: Lifecycle

  override init(presenter: AuthenticationPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  // MARK: Internal

  weak var router: AuthenticationRouting?
  weak var listener: AuthenticationListener?

}

// MARK: AuthenticationPresentableListener

extension AuthenticationInteractor: AuthenticationPresentableListener {
  func didLogin() {
    listener?.routeToLogin()
  }
}
