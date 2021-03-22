@testable import Application

class SearchListenerMock: SearchListener {

  var routeToSubFeedCallCount = 0
  var routeToSubFeedHandler: (() -> Void)?

  func routeToSubFeed(model: ProfileContentSectionModel.Cell) {
    routeToSubFeedCallCount += 1
    routeToSubFeedHandler?()
  }
}
