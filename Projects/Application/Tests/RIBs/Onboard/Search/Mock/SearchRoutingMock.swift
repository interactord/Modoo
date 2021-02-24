import RIBs
import RxRelay
import RxSwift
@testable import Application

// MARK: - SearchRoutingMock

class SearchRoutingMock: RoutingMock {
  var routeToSubProfileUUIDCallCount = 0
  var routeToSubProfileUUIDHandler: (() -> Void)?
  var routeToBackCallCount = 0
  var routeToBackHandler: (() -> Void)?
}

// MARK: SearchRouting

extension SearchRoutingMock: SearchRouting {
  func routeToSubProfile(uid: String) {
    routeToSubProfileUUIDCallCount += 1
    routeToSubProfileUUIDHandler?()
  }

  func routeToBack() {
    routeToBackCallCount += 1
    routeToBackHandler?()
  }
}
