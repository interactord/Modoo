import RIBs
import RxRelay
import RxSwift

@testable import Application

class SubFeedInteractableMock: InteractableMock, SubFeedInteractable {

  // MARK: Lifecycle

  override init() {
    super.init()
  }

  // MARK: Internal

  var router: SubFeedRouting?
  var listener: SubFeedListener?

}
