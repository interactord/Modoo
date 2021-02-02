import RIBs
import RxRelay
import RxSwift

@testable import Application

class RegisterInteractableMock: InteractableMock, RegisterInteractable {

  // MARK: Lifecycle

  override init() {
    super.init()
  }

  // MARK: Internal

  var router: RegisterRouting?
  var listener: RegisterListener?

}
