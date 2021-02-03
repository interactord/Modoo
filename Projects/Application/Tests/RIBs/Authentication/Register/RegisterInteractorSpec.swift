import Nimble
import Quick
@testable import Application

class RegisterInteractorSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: RegisterInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: RegisterViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: RegisterListenerMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var router: RegisterRoutingMock!

    beforeEach {
      viewController = RegisterViewControllableMock()
      listener = RegisterListenerMock()
      interactor = RegisterInteractor(presenter: viewController)
      router = RegisterRoutingMock(
        interactable: interactor,
        viewControllable: viewController)
      interactor.listener = listener
      interactor.router = router
      interactor.activate()
    }

    describe("RegisterInteractorSpec") {
      context("joinAction 실행시") {
        beforeEach {
          interactor.joinAction()
        }

        it("listener routeToLoggedInCallCount는 1이다") {
          expect(listener.routeToLoggedInCallCount) == 1
        }
      }

      context("signUpAction 실행시") {
        beforeEach {
          interactor.signUpAction()
        }

        it("listener routeToLogin는 1이다") {
          expect(listener.routeToLogInCallCount) == 1
        }
      }
    }
  }
}
