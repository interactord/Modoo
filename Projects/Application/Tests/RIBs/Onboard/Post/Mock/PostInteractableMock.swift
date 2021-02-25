import RIBs
import RxRelay
import RxSwift
@testable import Application

class PostInteractableMock: InteractableMock, PostInteractable {

  // MARK: Lifecycle

  override init() {
    super.init()
  }

  // MARK: Internal

  var router: PostRouting?
  var listener: PostListener?

}
