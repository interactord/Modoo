import RIBs
import RxSwift

protocol OnboardRouting: ViewableRouting {
}

protocol OnboardPresentable: Presentable {
  var listener: OnboardPresentableListener? { get set }
}

protocol OnboardListener: class {
}

final class OnboardInteractor: PresentableInteractor<OnboardPresentable>, OnboardInteractable {
  weak var router: OnboardRouting?
  weak var listener: OnboardListener?

  override init(presenter: OnboardPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
}

// MARK: OnboardPresentableListener

extension OnboardInteractor: OnboardPresentableListener {
}
