import RIBs
import RxRelay
import RxSwift

@testable import Application

// MARK: - AuthenticationInteractableMock

class AuthenticationInteractableMock: InteractableMock {

  // MARK: Lifecycle

  override init() {
    super.init()
  }

  // MARK: Internal

  var router: AuthenticationRouting?
  var listener: AuthenticationListener?
  var didLoginCallCount = 0
  var didLoginHandler: (() -> Void)?
  var didRegisterCallCount = 0
  var didRegisterHandler: (() -> Void)?

}

// MARK: AuthenticationInteractable

extension AuthenticationInteractableMock: AuthenticationInteractable {

  func didLogin() {
    didLoginCallCount += 1
    didLoginHandler?()
  }

  func didRegister() {
    didRegisterCallCount += 1
    didRegisterHandler?()
  }

}
