import RIBs
import RxSwift

protocol LoginRouting: ViewableRouting {}

protocol LoginPresentable: Presentable {
  var listener: LoginPresentableListener? { get set }
}

protocol LoginListener: AnyObject {
  func didLogin()
}

final class LoginInteractor: PresentableInteractor<LoginPresentable>, LoginInteractable {
  weak var router: LoginRouting?
  weak var listener: LoginListener?

  override init(presenter: LoginPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
}

// MARK: LoginPresentableListener

extension LoginInteractor: LoginPresentableListener {
  func login() {
    print("login")
  }
}
