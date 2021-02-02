import Nimble
import Quick

@testable import Application

class AuthenticationInteractorSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: AuthenticationInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: AuthenticationViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: AuthenticationListenerMock!

    beforeEach {
      viewController = AuthenticationViewControllableMock()
      listener = AuthenticationListenerMock()
      interactor = AuthenticationInteractor(presenter: viewController)
      interactor.listener = listener
      interactor.activate()
    }

    describe("AuthenticationInteractor") {
      context("didLogin 실행시") {
        beforeEach {
          interactor.didLogin()
        }

        it("listener routeToLoginCallCount는 1이다") {
          expect(listener.routeToLoginCallCount) == 1
        }
      }
    }
  }
}
