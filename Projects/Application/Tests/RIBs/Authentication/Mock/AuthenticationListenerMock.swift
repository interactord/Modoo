@testable import Application

class AuthenticationListenerMock: AuthenticationListener {

  var routeToOnboardCallCount = 0
  var routeToOnboardHandler: (() -> Void)?

  func routeToOnboard() {
    routeToOnboardCallCount += 1
    routeToOnboardHandler?()
  }
}
