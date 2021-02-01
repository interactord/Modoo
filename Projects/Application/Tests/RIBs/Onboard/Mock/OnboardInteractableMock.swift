import RIBs
import RxRelay
import RxSwift
@testable import Application

class OnboardInteractableMock: InteractableMock, OnboardInteractable {

  // MARK: Lifecycle

  // MARK: Function Handler

  override init() {
    super.init()
  }

  // MARK: Internal

  // MARK: Variables

  var router: OnboardRouting?
  var listener: OnboardListener?

}
