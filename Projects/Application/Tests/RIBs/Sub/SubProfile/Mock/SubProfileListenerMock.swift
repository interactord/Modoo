@testable import Application

class SubProfileListenerMock: SubProfileListener {

  var routeToBackCallCount = 0
  var routeToBackHandler: (() -> Void)?

  var routeToSubFeedCallCount = 0
  var routeToSubFeedHandler: (() -> Void)?

  func routeToBack() {
    routeToBackCallCount += 1
    routeToBackHandler?()
  }

  func routeToSubFeed(model: ProfileContentSectionModel.Cell) {
    routeToSubFeedCallCount += 1
    routeToSubFeedHandler?()
  }
}
