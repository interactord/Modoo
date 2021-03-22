import RIBs
import RxRelay
import RxSwift

@testable import Application

// MARK: - ProfileInteractableMock

class ProfileInteractableMock: InteractableMock {

  // MARK: Lifecycle

  override init() {
    super.init()
  }

  // MARK: Internal

  var router: ProfileRouting?
  var listener: ProfileListener?

}

// MARK: ProfileInteractable

extension ProfileInteractableMock: ProfileInteractable {
  func routeToBackFromSubFeed() {
    router?.routeToBackFromSubFeed()
  }
}
