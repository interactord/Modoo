import RIBs
import RxRelay
import RxSwift
@testable import Application

// MARK: - RootInteractableMock

class RootInteractableMock: InteractableMock, RootInteractable {

  // MARK: Lifecycle

  override init() {
    super.init()
  }

  // MARK: Internal

  // MARK: Variables

  var router: RootRouting?
  var listener: RootListener?

  // MARK: Function Handler

  var didLoginCallCount: Int = 0
  var didLoginHandler: (() -> Void)?

}

// MARK: RootPresentableListener

extension RootInteractableMock: RootPresentableListener {
  func didLogin() {
    didLoginCallCount += 1
    didLoginHandler?()
  }
}
