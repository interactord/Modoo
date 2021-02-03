@testable import Application

class LoginListenerMock: LoginListener {

  var routeToLoggedInCallCount = 0
  var routeToLoggedIninHandler: (() -> Void)?
  var routeToRegisterCallCount = 0
  var routeToRegisterHandler: (() -> Void)?

  func routeToLoggedIn() {
    routeToLoggedInCallCount += 1
    routeToLoggedIninHandler?()
  }

  func routeToRegister() {
    routeToRegisterCallCount += 1
    routeToRegisterHandler?()
  }

}
