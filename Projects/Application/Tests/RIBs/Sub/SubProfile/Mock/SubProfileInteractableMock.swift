import RIBs
import RxRelay
import RxSwift
@testable import Application

class SubProfileInteractableMock: InteractableMock, SubProfileInteractable {

  // MARK: Lifecycle

  override init() {
    super.init()
  }

  // MARK: Internal

  var router: SubProfileRouting?
  var listener: SubProfileListener?

}
