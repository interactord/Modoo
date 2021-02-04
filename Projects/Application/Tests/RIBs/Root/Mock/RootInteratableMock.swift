import RIBs
import RxRelay
import RxSwift
@testable import Application

// MARK: - RootInteractableMock

class RootInteractableMock: InteractableMock, RootPresentableListener {

  var router: RootRouting?
  var listener: RootListener?
  var routeToOnboardCallCount: Int = 0
  var routeToOnboardHandler: (() -> Void)?
  var routeToAuthenticationCallCount: Int = 0
  var routeToAuthenticationHandler: (() -> Void)?

}

// MARK: RootInteractable

extension RootInteractableMock: RootInteractable {
  func routeToOnboard() {
    routeToOnboardCallCount += 1
    routeToOnboardHandler?()
  }

  func routeToAuthentication() {
    routeToAuthenticationCallCount += 1
    routeToAuthenticationHandler?()
  }
}
