import RIBs
import RxSwift

// MARK: - RootRouting

protocol RootRouting: ViewableRouting {
  func cleanupViews()
  func routeToLoggedIn()
}

// MARK: - RootPresentable

protocol RootPresentable: Presentable {
  var listener: RootPresentableListener? { get set }
}

// MARK: - RootListener

protocol RootListener: AnyObject {}

// MARK: - RootInteractor

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable {

  // MARK: Lifecycle

  override init(presenter: RootPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  // MARK: Internal

  weak var router: RootRouting?
  weak var listener: RootListener?

  override func willResignActive() {
    super.willResignActive()
    router?.cleanupViews()
  }
}

// MARK: RootPresentableListener

extension RootInteractor: RootPresentableListener {
  func didLogin() {
    router?.routeToLoggedIn()
  }
}
