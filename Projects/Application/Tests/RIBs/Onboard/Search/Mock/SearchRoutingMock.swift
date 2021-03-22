import RIBs
import RxRelay
import RxSwift
@testable import Application

// MARK: - SearchRoutingMock

class SearchRoutingMock: RoutingMock {
  var routeToSubProfileUUIDCallCount = 0
  var routeToSubProfileUUIDHandler: (() -> Void)?

  var routeToBackFromSubFeedCallCount = 0
  var routeToBackFromSubFeedHandler: (() -> Void)?

  var routeToBackFromSubProfileCallCount = 0
  var routeToBackFromSubProfileHandler: (() -> Void)?

  var routeToSubFeedCallCount = 0
  var routeToSubFeedHandler: (() -> Void)?
}

// MARK: SearchRouting

extension SearchRoutingMock: SearchRouting {
  func routeToSubProfile(uid: String) {
    routeToSubProfileUUIDCallCount += 1
    routeToSubProfileUUIDHandler?()
  }

  func routeToSubFeed(model: ProfileContentSectionModel.Cell) {
    routeToSubFeedCallCount += 1
    routeToSubFeedHandler?()
  }

  func routeToBackFromSubFeed() {
    routeToBackFromSubFeedCallCount += 1
    routeToBackFromSubFeedHandler?()
  }

  func routeToBackFromSubProfile() {
    routeToBackFromSubProfileCallCount += 1
    routeToBackFromSubProfileHandler?()
  }
}
