import RIBs
import RxSwift

// MARK: - RootRouting

protocol RootRouting: ViewableRouting {
  func cleanupViews()
  func routeToAuthentication()
  func routeToOnboard()
}

// MARK: - RootPresentable

protocol RootPresentable: Presentable {
  var listener: RootPresentableListener? { get set }
}

// MARK: - RootListener

protocol RootListener: AnyObject {}

// MARK: - RootInteractor

final class RootInteractor: PresentableInteractor<RootPresentable> {

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

// MARK: RootInteractable

extension RootInteractor: RootInteractable {
  func routeToAuthentication() {
    router?.routeToAuthentication()
  }

  func routeToOnboard() {
    router?.routeToOnboard()
  }
}

// MARK: RootPresentableListener

extension RootInteractor: RootPresentableListener {
}
