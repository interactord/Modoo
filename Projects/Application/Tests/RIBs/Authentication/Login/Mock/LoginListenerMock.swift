@testable import Application

class LoginListenerMock: LoginListener {
  // MARK: Function Handler

  var didLoginCallCount: Int = 0
  var didLoginHandler: (() -> Void)?

  func didLogin() {
    didLoginCallCount += 1
    didLoginHandler?()
  }
}
