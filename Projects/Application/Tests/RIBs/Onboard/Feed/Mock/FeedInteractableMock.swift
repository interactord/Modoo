import RIBs
import RxRelay
import RxSwift
@testable import Application

class FeedInteractableMock: InteractableMock, FeedInteractable {

  // MARK: Lifecycle

  override init() {
    super.init()
  }

  // MARK: Internal

  var router: FeedRouting?
  var listener: FeedListener?

}
