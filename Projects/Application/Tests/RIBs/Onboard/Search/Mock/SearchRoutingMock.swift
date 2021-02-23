import RIBs
import RxRelay
import RxSwift
@testable import Application

// MARK: - SearchRoutingMock

class SearchRoutingMock: RoutingMock {
  var routeToSubProfileUUIDCallCount = 0
  var routeToSubProfileUUIDHandler: (() -> Void)?
}

// MARK: SearchRouting

extension SearchRoutingMock: SearchRouting {
  func routeToSubProfile(uid: String) {
    routeToSubProfileUUIDCallCount += 1
    routeToSubProfileUUIDHandler?()
  }
}
