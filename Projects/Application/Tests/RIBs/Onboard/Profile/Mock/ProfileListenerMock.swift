@testable import Application

class ProfileListenerMock: ProfileListener {

  var routeToAuthenticationCallCount = 0
  var routeToAuthenticationHandler: (() -> Void)?

  var routeToSubFeedCallCount = 0
  var routeToSubFeedHandler: (() -> Void)?

  func routeToAuthentication() {
    routeToAuthenticationCallCount += 1
    routeToAuthenticationHandler?()
  }

  func routeToSubFeed() {
    routeToSubFeedCallCount += 1
    routeToSubFeedHandler?()
  }
}
