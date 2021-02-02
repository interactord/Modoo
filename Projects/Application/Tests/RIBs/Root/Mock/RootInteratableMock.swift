import RIBs
import RxRelay
import RxSwift
@testable import Application

// MARK: - RootInteractableMock

class RootInteractableMock: InteractableMock {

  var router: RootRouting?
  var listener: RootListener?
  var routeToLoginCallCount: Int = 0
  var routeToLoginHandler: (() -> Void)?

}

// MARK: RootInteractable

extension RootInteractableMock: RootInteractable {
  func routeToLoggedIn() {
    routeToLogin()
  }
}

// MARK: RootPresentableListener

extension RootInteractableMock: RootPresentableListener {
  func routeToLogin() {
    routeToLoginCallCount += 1
    routeToLoginHandler?()
  }
}
