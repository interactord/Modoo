@testable import Application

class RegisterListenerMock: RegisterListener {
  var routeToLoggedInCallCount = 0
  var routeToLoggedIninHandler: (() -> Void)?
  var routeToLogInCallCount = 0
  var routeToLogIninHandler: (() -> Void)?

  func routeToLogin() {
    routeToLogInCallCount += 1
    routeToLogIninHandler?()
  }

  func routeToLoggedIn() {
    routeToLoggedInCallCount += 1
    routeToLoggedIninHandler?()
  }

}
