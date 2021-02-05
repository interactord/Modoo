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
      interactor = RegisterInteractor(
        presenter: viewController,
        initialState: .init())
      router = RegisterRoutingMock(
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

    describe("RegisterInteractor activate 실행시") {
      beforeEach {
        interactor.activate()
      }
      afterEach {
        interactor.deactivate()
      }

      context("signUp action 이벤트 발생시") {
        beforeEach {
          interactor.action.onNext(.signUp)
        }

        it("listener routeToOnboardCallCount가 1이다") {
          expect(listener.routeToOnboardCallCount).toEventually(equal(1), timeout: .milliseconds(300))
        }
      }

      context("register action 이벤트 발생시") {
        beforeEach {
          interactor.action.onNext(.login)
        }

        it("listener routeToLogInCallCount가 1이다") {
          expect(listener.routeToLogInCallCount).toEventually(equal(1), timeout: .milliseconds(300))
        }
      }
    }
  }
}
