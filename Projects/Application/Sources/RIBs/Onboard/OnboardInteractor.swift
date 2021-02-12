import RIBs
import RxSwift

// MARK: - OnboardRouting

protocol OnboardRouting: ViewableRouting {
  func setOnceViewControllers()
}

// MARK: - OnboardPresentable

protocol OnboardPresentable: Presentable {
  var listener: OnboardPresentableListener? { get set }
}

// MARK: - OnboardListener

protocol OnboardListener: AnyObject {
  func routeToAuthentication()
}

// MARK: - OnboardInteractor

final class OnboardInteractor: PresentableInteractor<OnboardPresentable>, OnboardInteractable {

  // MARK: Lifecycle

  override init(presenter: OnboardPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  deinit {
    print("OnboardInteractor deinit...")
  }

  // MARK: Internal

  weak var router: OnboardRouting?
  weak var listener: OnboardListener?

  override func willResignActive() {
    super.willResignActive()
    router?.setOnceViewControllers()
  }
}

// MARK: OnboardPresentableListener

extension OnboardInteractor: OnboardPresentableListener {
  func onLogout() {
    listener?.routeToAuthentication()
  }
}
