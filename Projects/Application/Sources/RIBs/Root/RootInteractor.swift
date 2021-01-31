import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
  func cleanupViews()
  func routeToLoggedIn()
}

protocol RootPresentable: Presentable {
  var listener: RootPresentableListener? { get set }
}

protocol RootListener: class {
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootPresentableListener {
  weak var router: RootRouting?
  weak var listener: RootListener?

  override init(presenter: RootPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  override func willResignActive() {
    super.willResignActive()
    router?.cleanupViews()
  }
}

// MARK: RootInteractable

extension RootInteractor: RootInteractable {
  func didLogin() {
    router?.routeToLoggedIn()
  }
}
