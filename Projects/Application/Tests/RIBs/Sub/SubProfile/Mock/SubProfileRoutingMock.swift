import RIBs
import RxRelay
import RxSwift
@testable import Application

// MARK: - SubProfileRoutingMock

class SubProfileRoutingMock: RoutingMock {
  var routeToSubFeedCallCount = 0
  var routeToSubFeedHandler: (() -> Void)?
}

// MARK: SubProfileRouting

extension SubProfileRoutingMock: SubProfileRouting {
  func routeToSubFeed(model: ProfileContentSectionModel.Cell) {
    routeToSubFeedCallCount += 1
    routeToSubFeedHandler?()
  }
}
