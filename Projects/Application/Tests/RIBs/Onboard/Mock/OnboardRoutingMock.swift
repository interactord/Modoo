import RIBs
import RxRelay
import RxSwift
@testable import Application

// MARK: - OnboardRoutingMock

class OnboardRoutingMock: RoutingMock {
  var setOnceViewControllersCallCount = 0
  var setOnceViewControllersHandler: (() -> Void)?

  var routeToPostCallCount = 0
  var routeToPostHandler: (() -> Void)?

  var routeToCloseCallCount = 0
  var routeToCloseHandler: (() -> Void)?

  var routeToSubFeedCallCount = 0
  var routeToSubFeedHandler: (() -> Void)?

  var routeToCommentCallCount = 0
  var routeToCommentHandler: (() -> Void)?

  var routeToBackFromCommentCallCount = 0
  var routeToBackFromCommentHandler: (() -> Void)?
}

// MARK: OnboardRouting

extension OnboardRoutingMock: OnboardRouting {

  func setOnceViewControllers() {
    childrenSetCallCount += 1
    setOnceViewControllersHandler?()
  }

  func routeToPost(image: UIImage) {
    routeToPostCallCount += 1
    routeToPostHandler?()
  }

  func routeToClose() {
    routeToCloseCallCount += 1
    routeToCloseHandler?()
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
