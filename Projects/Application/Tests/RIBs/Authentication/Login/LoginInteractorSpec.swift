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
      interactor = LoginInteractor(presenter: viewController, initialState: .init())
      router = LoginRoutingMock(interactable: interactor, viewControllable: viewController)
      listener = LoginListenerMock()
      viewController.listener = interactor
      interactor.router = router
      interactor.listener = listener
    }
    afterEach {
      interactor = nil
      viewController = nil
      router = nil
      listener = nil
    }

    describe("LoginInteractor activate 실행시") {

      beforeEach {
        interactor.activate()
      }
      afterEach {
        interactor.deactivate()
      }

      context("login action 이벤트 발생시") {
        beforeEach {
          interactor.action.onNext(.login)
        }

        it("listener routeToOnboardCallCount가 1이다") {
          expect(listener.routeToOnboardCallCount).toEventually(equal(1), timeout: .milliseconds(300))
        }
      }

      context("register action 이벤트 발생시") {
        beforeEach {
          interactor.action.onNext(.register)
        }

        it("listener routeToRegisterCallCount가 호출이 된다") {
          expect(listener.routeToRegisterCallCount).toEventually(equal(1), timeout: .milliseconds(300))
        }
      }
    }
  }
}
