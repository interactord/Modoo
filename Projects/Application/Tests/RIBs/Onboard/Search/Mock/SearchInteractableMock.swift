import RIBs
import RxRelay
import RxSwift

@testable import Application

// MARK: - SearchInteractableMock

class SearchInteractableMock: InteractableMock {

  // MARK: Lifecycle

  override init() {
    super.init()
  }

  // MARK: Internal

  var router: SearchRouting?
  var listener: SearchListener?

}

// MARK: SearchInteractable

extension SearchInteractableMock: SearchInteractable {
  func routeToSubFeed(model: ProfileContentSectionModel.Cell) {
    router?.routeToSubFeed(model: model)
  }

  func routeToBackFromSubFeed() {
    router?.routeToBackFromSubFeed()
  }

  func routeToBackFromSubProfile() {
    router?.routeToBackFromSubProfile()
  }
}
