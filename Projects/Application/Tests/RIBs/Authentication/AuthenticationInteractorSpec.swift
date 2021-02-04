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
    // swiftlint:disable implicitly_unwrapped_optional
    var router: AuthenticationRoutingMock!

    beforeEach {
      viewController = AuthenticationViewControllableMock()
      listener = AuthenticationListenerMock()
      interactor = AuthenticationInteractor(presenter: viewController)
      router = AuthenticationRoutingMock(
        interactable: interactor,
        viewControllable: viewController)
      interactor.listener = listener
      interactor.router = router
    }
    afterEach {
      interactor = nil
      viewController = nil
      listener = nil
      router = nil
    }

    describe("AuthenticationInteractor activate 실행시") {
      beforeEach {
        interactor.activate()
      }

      context("routeToOnboard 실행시") {
        beforeEach {
          interactor.routeToOnboard()
        }

        it("listener routeToOnboardCallCount는 1이다") {
          expect(listener.routeToOnboardCallCount) == 1
        }
      }

      context("routeToRegister 실행시") {
        beforeEach {
          interactor.routeToRegister()
        }

        it("router routeToRegisterCallCount는 1이다") {
          expect(router.routeToRegisterCallCount) == 1
        }
      }

      context("routeToLogin 실행시") {
        beforeEach {
          interactor.routeToLogin()
        }

        it("router routeToLoginCallCount는 1이다") {
          expect(router.routeToLoginCallCount) == 1
        }
      }
    }
  }
}
