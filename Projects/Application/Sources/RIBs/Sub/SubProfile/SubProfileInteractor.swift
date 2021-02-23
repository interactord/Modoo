import RIBs
import RxSwift

// MARK: - SubProfileRouting

protocol SubProfileRouting: ViewableRouting {
}

// MARK: - SubProfilePresentable

protocol SubProfilePresentable: Presentable {
  var listener: SubProfilePresentableListener? { get set }
}

// MARK: - SubProfileListener

protocol SubProfileListener: AnyObject {
}

// MARK: - SubProfileInteractor

final class SubProfileInteractor: PresentableInteractor<SubProfilePresentable>, SubProfileInteractable, SubProfilePresentableListener {

  // MARK: Lifecycle

  init(
    presenter: SubProfilePresentable,
    userUseCase: UserUseCase,
    uid: String)
  {
    defer { presenter.listener = self }
    self.uid = uid
    self.userUseCase = userUseCase
    super.init(presenter: presenter)
  }

  deinit {
    print("SubProfileInteractor deinit...")
  }

  // MARK: Internal

  weak var router: SubProfileRouting?
  weak var listener: SubProfileListener?

  // MARK: Private

  private let uid: String
  private let userUseCase: UserUseCase

}
