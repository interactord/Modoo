@testable import Application

// MARK: - PostListenerMock

class PostListenerMock {
  var dismissPostCallCount = 0
  var dismissPostHandler: (() -> Void)?
}

// MARK: PostListener

extension PostListenerMock: PostListener {
  func dismissPost() {
    dismissPostCallCount += 1
    dismissPostHandler?()
  }
}
