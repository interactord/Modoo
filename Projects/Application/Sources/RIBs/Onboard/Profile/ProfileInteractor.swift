import RIBs
import RxSwift

// MARK: - ProfileRouting

protocol ProfileRouting: ViewableRouting {
}

// MARK: - ProfilePresentable

protocol ProfilePresentable: Presentable {
  var listener: ProfilePresentableListener? { get set }
}

// MARK: - ProfileListener

protocol ProfileListener: AnyObject {
}

// MARK: - ProfileInteractor

final class ProfileInteractor: PresentableInteractor<ProfilePresentable>, ProfileInteractable, ProfilePresentableListener {

  // MARK: Lifecycle

  override init(presenter: ProfilePresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  deinit {
    print("ProfileInteractor deinit...")
  }

  // MARK: Internal

  weak var router: ProfileRouting?
  weak var listener: ProfileListener?

}
