import RIBs
import RxRelay
import RxSwift
@testable import Application

// MARK: - ProfileRoutingMock

class ProfileRoutingMock: RoutingMock {
  var routeToSubFeedCallCount = 0
  var routeToSubFeedHandler: (() -> Void)?

  var routeToBackFromSubFeedCallCount = 0
  var routeToBackFromSubFeedHandler: (() -> Void)?

  var routeToCommentCallCount = 0
  var routeToCommentHandler: (() -> Void)?

  var routeToBackFromCommentCallCount = 0
  var routeToBackFromCommentHandler: (() -> Void)?
}

// MARK: ProfileRouting

extension ProfileRoutingMock: ProfileRouting {
  func routeToSubFeed(model: ProfileContentSectionModel.Cell) {
    routeToSubFeedCallCount += 1
    routeToSubFeedHandler?()
  }

  func routeToBackFromSubFeed() {
    routeToBackFromSubFeedCallCount += 1
    routeToBackFromSubFeedHandler?()
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
