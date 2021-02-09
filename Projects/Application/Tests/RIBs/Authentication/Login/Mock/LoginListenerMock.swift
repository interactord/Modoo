import RxSwift

@testable import Application

class LoginListenerMock: LoginListener {

  var routeToOnboardCallCount = 0
  var routeToOnboardHandler: (() -> Void)?
  var routeToRegisterCallCount = 0
  var routeToRegisterHandler: (() -> Void)?

  func routeToOnboard() {
    routeToOnboardCallCount += 1
    routeToOnboardHandler?()
  }

  func routeToRegister() {
    routeToRegisterCallCount += 1
    routeToRegisterHandler?()
  }

}
