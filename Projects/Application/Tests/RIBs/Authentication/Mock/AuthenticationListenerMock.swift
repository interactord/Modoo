@testable import Application

class AuthenticationListenerMock: AuthenticationListener {

  var routeToLoginCallCount = 0
  var routeToLoginHandler: (() -> Void)?


  func routeToLogin() {
    routeToLoginCallCount += 1
    routeToLoginHandler?()
  }
}
