@testable import Application

// MARK: - SubFeedListenerMock

class SubFeedListenerMock: SubFeedListener {
  var routeToBackCallCount = 0
  var routeToBackHandler: (() -> Void)?
}

extension SubFeedListenerMock {
  func routeToBackFromSubFeed() {
    routeToBackCallCount += 1
    routeToBackHandler?()
  }
}
