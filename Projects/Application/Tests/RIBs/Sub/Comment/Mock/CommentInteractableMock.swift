import RIBs
import RxRelay
import RxSwift

@testable import Application

class CommentInteractableMock: InteractableMock, CommentInteractable {

  // MARK: Lifecycle

  override init() {
    super.init()
  }

  // MARK: Internal

  var router: CommentRouting?
  var listener: CommentListener?

}
