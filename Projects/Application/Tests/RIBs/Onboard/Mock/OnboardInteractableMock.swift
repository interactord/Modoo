import RIBs
import RxRelay
import RxSwift
@testable import Application

// MARK: - OnboardInteractableMock

class OnboardInteractableMock: InteractableMock {

  // MARK: Lifecycle

  // MARK: Function Handler

  override init() {
    super.init()
  }

  // MARK: Internal

  // MARK: Variables

  var router: OnboardRouting?
  var listener: OnboardListener?

  var routeToAuthenticationCallCount = 0
  var routeToAuthenticationHandler: (() -> Void)?

  var routeToCloseCallCount = 0
  var routeToCloseHandler: (() -> Void)?

  var routeToSubFeedCallCount = 0
  var routeToSubFeedHandler: (() -> Void)?

  var routeToCommentCallCount = 0
  var routeToCommentHander: (() -> Void)?

  var routeToBackFromCommentCallCount = 0
  var routeToBackFromCommentHander: (() -> Void)?
}

// MARK: OnboardInteractable

extension OnboardInteractableMock: OnboardInteractable {
  func routeToAuthentication() {
    routeToAuthenticationCallCount += 1
    routeToAuthenticationHandler?()
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
    routeToCommentHander?()
  }

  func routeToBackFromComment() {
    routeToBackFromCommentCallCount += 1
    routeToBackFromCommentHander?()
  }
}
