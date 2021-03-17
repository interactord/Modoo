@testable import Application

// MARK: - PostListenerMock

class PostListenerMock {
  var routeToCloseCallCount = 0
  var routeToCloseHandler: (() -> Void)?
}

// MARK: PostListener

extension PostListenerMock: PostListener {
  func routeToClose() {
    routeToCloseCallCount += 1
    routeToCloseHandler?()
  }
}
