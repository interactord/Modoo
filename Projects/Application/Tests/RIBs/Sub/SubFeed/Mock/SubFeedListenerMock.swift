@testable import Application

// MARK: - SubFeedListenerMock

class SubFeedListenerMock: SubFeedListener {
  var routeToBackCallCount = 0
  var routeToBackHandler: (() -> Void)?

  var routeToCommentCallCount = 0
  var routeToCommentHandler: (() -> Void)?
}

extension SubFeedListenerMock {
  func routeToBackFromSubFeed() {
    routeToBackCallCount += 1
    routeToBackHandler?()
  }

  func routeToComment(item: FeedContentSectionModel.Cell) {
    routeToCommentCallCount += 1
    routeToCommentHandler?()
  }
}
