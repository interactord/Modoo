@testable import Application

// MARK: - SearchListenerMock

class SearchListenerMock {

  var routeToSubFeedCallCount = 0
  var routeToSubFeedHandler: (() -> Void)?

  var routeToCommentCallCount = 0
  var routeToCommentHandler: (() -> Void)?

  var routeToBackFromCommentCallCount = 0
  var routeToBackFromCommentHandler: (() -> Void)?
}

// MARK: SearchListener

extension SearchListenerMock: SearchListener {

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
