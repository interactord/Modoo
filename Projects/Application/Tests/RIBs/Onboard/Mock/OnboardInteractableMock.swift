import RIBs
import RxRelay
import RxSwift
@testable import Application

// MARK: - OnboardInteractableMock

class OnboardInteractableMock: InteractableMock {

  // MARK: Lifecycle

  // MARK: Function Handler

  override init() {
    super.init()
  }

  // MARK: Internal

  // MARK: Variables

  var router: OnboardRouting?
  var listener: OnboardListener?

  var routeToAuthenticationCallCount = 0
  var routeToAuthenticationHandler: (() -> Void)?
  var dismissPostCallCount = 0
  var dismissPostHandler: (() -> Void)?

}

// MARK: OnboardInteractable

extension OnboardInteractableMock: OnboardInteractable {
  func routeToAuthentication() {
    routeToAuthenticationCallCount += 1
    routeToAuthenticationHandler?()
  }

  func dismissPost() {
    dismissPostCallCount += 1
    dismissPostHandler?()
  }
}
