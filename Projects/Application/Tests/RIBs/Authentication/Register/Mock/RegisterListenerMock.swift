@testable import Application

class RegisterListenerMock: RegisterListener {
  var routeToOnboardCallCount = 0
  var routeToOnboardHandler: (() -> Void)?
  var routeToLogInCallCount = 0
  var routeToLogIninHandler: (() -> Void)?

  func routeToLogin() {
    routeToLogInCallCount += 1
    routeToLogIninHandler?()
  }

  func routeToOnboard() {
    routeToOnboardCallCount += 1
    routeToOnboardHandler?()
  }

}
