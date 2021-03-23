import RIBs
import RxRelay
import RxSwift
@testable import Application

// MARK: - FeedInteractableMock

class FeedInteractableMock: InteractableMock {

  // MARK: Lifecycle

  override init() {
    super.init()
  }

  // MARK: Internal

  var router: FeedRouting?
  var listener: FeedListener?

}

// MARK: FeedInteractable

extension FeedInteractableMock: FeedInteractable {
  func routeToBackFromComment() {
    listener?.routeToBackFromComment()
  }
}
