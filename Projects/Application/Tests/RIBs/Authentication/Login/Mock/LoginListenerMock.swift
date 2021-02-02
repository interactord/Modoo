@testable import Application

class LoginListenerMock: LoginListener {

  var didLoginCallCount: Int = 0
  var didLoginHandler: (() -> Void)?

  func didLogin() {
    didLoginCallCount += 1
    didLoginHandler?()
  }
}
