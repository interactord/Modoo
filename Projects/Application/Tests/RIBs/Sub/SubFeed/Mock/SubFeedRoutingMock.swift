import RIBs
import RxRelay
import RxSwift

@testable import Application

// MARK: - SubFeedRoutingMock

class SubFeedRoutingMock: RoutingMock {
  var routeToCommentCallCount = 0
  var routeToCommentHandler: (() -> Void)?
}

// MARK: SubFeedRouting

extension SubFeedRoutingMock: SubFeedRouting {
  func routeToComment(item: FeedContentSectionModel.Cell) {
    routeToCommentCallCount += 1
    routeToCommentHandler?()
  }
}
