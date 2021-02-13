import RIBs
import RxRelay
import RxSwift
@testable import Application

class ProfileInteractableMock: InteractableMock, ProfileInteractable {

  // MARK: Lifecycle

  override init() {
    super.init()
  }

  // MARK: Internal

  var router: ProfileRouting?
  var listener: ProfileListener?

}
