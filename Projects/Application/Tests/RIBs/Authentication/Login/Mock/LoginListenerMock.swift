@testable import Application

class LoginListenerMock: LoginListener {

  var didLoginCallCount: Int = 0
  var didLoginHandler: (() -> Void)?
  var didRegisterCallCount: Int = 0
  var didRegisterHandler: (() -> Void)?

  func didLogin() {
    didLoginCallCount += 1
    didLoginHandler?()
  }

  func didRegister() {
    didRegisterCallCount += 1
    didRegisterHandler?()
  }
}
