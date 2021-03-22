import RIBs
import RxRelay
import RxSwift
@testable import Application

// MARK: - FeedRoutingMock

class FeedRoutingMock: RoutingMock {
  var routeToCommentCallCount = 0
  var routeToCommentHandler: (() -> Void)?
}

// MARK: FeedRouting

extension FeedRoutingMock: FeedRouting {
  func routeToComment(item: FeedContentSectionModel.Cell) {
    routeToCommentCallCount += 1
    routeToCommentHandler?()
  }
}
