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
  func routeToBack() {
    router?.routeToBack()
  }

  func routeToSubFeed(model: ProfileContentSectionModel.Cell) {
    listener?.routeToSubFeed(model: model)
  }
}
