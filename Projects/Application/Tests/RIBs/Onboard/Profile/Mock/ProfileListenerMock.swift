@testable import Application

// MARK: - ProfileListenerMock

class ProfileListenerMock {

  var routeToAuthenticationCallCount = 0
  var routeToAuthenticationHandler: (() -> Void)?

  var routeToSubFeedCallCount = 0
  var routeToSubFeedHandler: (() -> Void)?

  var routeToCommentCallCount = 0
  var routeToCommentHandler: (() -> Void)?

  var routeToBackFromCommentCallCount = 0
  var routeToBackFromCommentHandler: (() -> Void)?
}

// MARK: ProfileListener

extension ProfileListenerMock: ProfileListener {

  func routeToAuthentication() {
    routeToAuthenticationCallCount += 1
    routeToAuthenticationHandler?()
  }

  func routeToSubFeed(model: ProfileContentSectionModel.Cell) {
    routeToSubFeedCallCount += 1
    routeToSubFeedHandler?()
  }

  func routeToComment(item: FeedContentSectionModel.Cell) {
    routeToCommentCallCount += 1
    routeToCommentHandler?()
  }

  func routeToBackFromComment() {
    routeToBackFromCommentCallCount += 1
    routeToBackFromCommentHandler?()
  }
}
