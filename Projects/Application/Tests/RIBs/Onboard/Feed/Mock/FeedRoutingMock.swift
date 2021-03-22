import RIBs
import RxRelay
import RxSwift
@testable import Application

// MARK: - FeedRoutingMock

class FeedRoutingMock: RoutingMock {
  var routeToCommentCallCount = 0
  var routeToCommentHandler: (() -> Void)?

  var routeToBackFromCommentCallCount = 0
  var routeToBackFromCommentHandler: (() -> Void)?
}

// MARK: FeedRouting

extension FeedRoutingMock: FeedRouting {
  func routeToComment(item: FeedContentSectionModel.Cell) {
    routeToCommentCallCount += 1
    routeToCommentHandler?()
  }

  func routeToBackFromComment() {
    routeToBackFromCommentCallCount += 1
    routeToBackFromCommentHandler?()
  }
}
