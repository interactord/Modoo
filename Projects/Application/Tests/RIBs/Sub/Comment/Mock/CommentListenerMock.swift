@testable import Application

// MARK: - CommentListenerMock

class CommentListenerMock {
  var routeToBackFromCommentCallCount = 0
  var routeToBackFromCommentHandler: (() -> Void)?
}

// MARK: CommentListener

extension CommentListenerMock: CommentListener {
  func routeToBackFromComment() {
    routeToBackFromCommentCallCount += 1
    routeToBackFromCommentHandler?()
  }
}
