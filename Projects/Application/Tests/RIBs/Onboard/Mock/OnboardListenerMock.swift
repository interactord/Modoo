@testable import Application

// MARK: - OnboardListenerMock

class OnboardListenerMock: OnboardListener {

  var routeToAuthenticationCallCount = 0
  var routeToAuthenticationHandler: (() -> Void)?

  func routeToAuthentication() {
    routeToAuthenticationCallCount += 1
    routeToAuthenticationHandler?()
  }
}
