import RIBs
import RxRelay
import RxSwift
@testable import Application

class LoginInteractableMock: InteractableMock, LoginInteractable {

  // MARK: Lifecycle

  override init() {
    super.init()
  }

  // MARK: Internal

  var router: LoginRouting?
  var listener: LoginListener?

}
