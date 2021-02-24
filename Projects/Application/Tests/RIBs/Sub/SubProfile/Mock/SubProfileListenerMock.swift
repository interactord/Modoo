@testable import Application

class SubProfileListenerMock: SubProfileListener {

  var routeToBackCallCount = 0
  var routeToBackHandler: (() -> Void)?

  func routeToBack() {
    routeToBackCallCount += 1
    routeToBackHandler?()
  }
}
