import RIBs
import RxSwift

// MARK: - OnboardRouting

protocol OnboardRouting: ViewableRouting {}

// MARK: - OnboardPresentable

protocol OnboardPresentable: Presentable {
  var listener: OnboardPresentableListener? { get set }
}

// MARK: - OnboardListener

protocol OnboardListener: AnyObject {}

// MARK: - OnboardInteractor

final class OnboardInteractor: PresentableInteractor<OnboardPresentable>, OnboardInteractable {

  // MARK: Lifecycle

  override init(presenter: OnboardPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  // MARK: Internal

  weak var router: OnboardRouting?
  weak var listener: OnboardListener?

}

// MARK: OnboardPresentableListener

extension OnboardInteractor: OnboardPresentableListener {}
