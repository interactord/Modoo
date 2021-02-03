import Nimble
import Quick
@testable import Application

class LoginInteractorSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: LoginInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: LoginViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var router: LoginRoutingMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: LoginListenerMock!

    beforeEach {
      viewController = LoginViewControllableMock()
      interactor = LoginInteractor(presenter: viewController)
      router = LoginRoutingMock(interactable: interactor, viewControllable: viewController)
      listener = LoginListenerMock()
      interactor.router = router
      interactor.listener = listener
      interactor.activate()
    }

    describe("LoginInteractor") {

      describe("loginAction 실행시") {
        beforeEach {
          interactor.loginAction()
        }

        it("listener routeToLoggedInCallCount는 1이디") {
          expect(listener.routeToLoggedInCallCount) == 1
        }
      }

      describe("registerAction 실행시") {
        beforeEach {
          interactor.registerAction()
        }

        it("listener routeToRegisterCallCount는 1이디") {
          expect(listener.routeToRegisterCallCount) == 1
        }
      }
    }
  }
}
