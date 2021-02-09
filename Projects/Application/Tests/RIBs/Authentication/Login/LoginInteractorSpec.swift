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
      let state = LoginDisplayModel.State.initialState()
      interactor = LoginInteractor(presenter: viewController, initialState: state)
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
          expect(listener.routeToOnboardCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
        }
      }

      context("register action 이벤트 발생시") {
        beforeEach {
          interactor.action.onNext(.register)
        }

        it("listener routeToRegisterCallCount가 호출이 된다") {
          expect(listener.routeToRegisterCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
        }
      }

      context("이메일 action 이벤트 발생시") {
        beforeEach {
          interactor.action.onNext(.email("123456"))
        }

        it("State 이메일이 변경된다") {
          expect(interactor.currentState.email) == "123456"
        }
      }

      context("패스워드 action 이벤트 발생시") {
        beforeEach {
          interactor.action.onNext(.password("123456"))
        }

        it("State 페스워드가 변경된다") {
          expect(interactor.currentState.password) == "123456"
        }
      }
    }
  }
}
