import RIBs
import RxRelay
import RxSwift

@testable import Application

// MARK: - SubFeedInteractableMock

class SubFeedInteractableMock: InteractableMock {

  // MARK: Lifecycle

  override init() {
    super.init()
  }

  // MARK: Internal

  var router: SubFeedRouting?
  var listener: SubFeedListener?

}

// MARK: SubFeedInteractable

extension SubFeedInteractableMock: SubFeedInteractable {
  func routeToBackFromComment() {
    listener?.routeToBackFromComment()
  }
}
