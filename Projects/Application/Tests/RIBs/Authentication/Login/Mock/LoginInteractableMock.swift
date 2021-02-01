import RIBs
import RxRelay
import RxSwift
@testable import Application

class LoginInteractableMock: InteractableMock, LoginInteractable {

  // MARK: Lifecycle

  // MARK: Function Handler

  override init() {
    super.init()
  }

  // MARK: Internal

  // MARK: Variables

  var router: LoginRouting?
  var listener: LoginListener?

}
