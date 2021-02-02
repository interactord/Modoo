@testable import Application

class AuthenticationListenerMock: AuthenticationListener {

  var routeToLoginCallCount = 0
  var routeToLoginHandler: (() -> Void)?

  func routeToLoggedIn() {
    routeToLoginCallCount += 1
    routeToLoginHandler?()
  }
}
