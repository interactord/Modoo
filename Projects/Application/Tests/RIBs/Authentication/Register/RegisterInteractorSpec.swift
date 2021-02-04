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

    }

    describe("RegisterInteractor activate 실행시") {
      beforeEach {
        interactor.activate()
      }

      afterEach {
        interactor = nil
        viewController = nil
        listener = nil
        router = nil
      }

      context("joinAction 실행시") {
        beforeEach {
          interactor.joinAction()
        }

        it("listener routeToOnboardCallCount는 1이다") {
          expect(listener.routeToOnboardCallCount) == 1
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
