import RIBs
import RxRelay
import RxSwift

@testable import Application

class AuthenticationInteractableMock: InteractableMock, AuthenticationInteractable {

  // MARK: Lifecycle

  override init() {
    super.init()
  }

  // MARK: Internal

  var router: AuthenticationRouting?
  var listener: AuthenticationListener?

}
