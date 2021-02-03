@testable import Application

class AuthenticationListenerMock: AuthenticationListener {

  var routeToLoggedInCallCount = 0
  var routeToLoggedInHandler: (() -> Void)?

  func routeToLoggedIn() {
    routeToLoggedInCallCount += 1
    routeToLoggedInHandler?()
  }
}
