@testable import Application

// MARK: - SubFeedListenerMock

class SubFeedListenerMock: SubFeedListener {
  var routeToCloseCallCount = 0
  var routeToCloseHandler: (() -> Void)?
}

extension SubFeedListenerMock {
  func routeToClose() {
    routeToCloseCallCount += 1
    routeToCloseHandler?()
  }
}
