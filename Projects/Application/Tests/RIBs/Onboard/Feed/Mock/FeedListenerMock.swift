@testable import Application

// MARK: - FeedListenerMock

class FeedListenerMock {

  var routeToCommentCallCount = 0
  var routeToCommentHandler: (() -> Void)?

  var routeToBackFromCommentCallCount = 0
  var routeToBackFromCommentHandler: (() -> Void)?
}

// MARK: FeedListener

extension FeedListenerMock: FeedListener {
  func routeToComment(item: FeedContentSectionModel.Cell) {
    routeToCommentCallCount += 1
    routeToCommentHandler?()
  }

  func routeToBackFromComment() {
    routeToBackFromCommentCallCount += 1
    routeToBackFromCommentHandler?()
  }
}
