import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
  func routeToLoggedIn()
}

protocol RootPresentable: Presentable {
  var listener: RootPresentableListener? { get set }
}

protocol RootListener: AnyObject {}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootPresentableListener {
  weak var router: RootRouting?
  weak var listener: RootListener?

  override init(presenter: RootPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
}

// MARK: RootInteractable

extension RootInteractor: RootInteractable {
  func didLogin() {
    router?.routeToLoggedIn()
  }
}
