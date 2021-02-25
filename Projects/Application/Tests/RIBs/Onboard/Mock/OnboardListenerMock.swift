@testable import Application

// MARK: - OnboardListenerMock

class OnboardListenerMock: OnboardListener {

  var routeToAuthenticationCallCount = 0
  var routeToAuthenticationHandler: (() -> Void)?

  var routeToPostCallCount = 0
  var routeToPostHandler: (() -> Void)?

  func routeToAuthentication() {
    routeToAuthenticationCallCount += 1
    routeToAuthenticationHandler?()
  }

}

// MARK: OnboardPresentableListener

extension OnboardListenerMock: OnboardPresentableListener {
  func routeToPost() {
    routeToPostCallCount += 1
    routeToPostHandler?()
  }

}
