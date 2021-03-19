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
    // swiftlint:disable implicitly_unwrapped_optional
    var authenticationUseCaseMock: FirebaseAuthenticationUseCaseMock!

    beforeEach {
      viewController = LoginViewControllableMock()
      let state = LoginDisplayModel.State.defaultValue()
      authenticationUseCaseMock = FirebaseAuthenticationUseCaseMock()
      interactor = LoginInteractor(
        presenter: viewController,
        initialState: state,
        authenticationUseCase: authenticationUseCaseMock)
      router = LoginRoutingMock(
        interactable: interactor,
        viewControllable: viewController)
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
      authenticationUseCaseMock = nil
    }

    describe("LoginInteractor activate 실행시") {

      beforeEach {
        interactor.activate()
      }
      afterEach {
        interactor.deactivate()
      }

      context("register action 이벤트 발생시") {
        beforeEach {
          interactor.action.onNext(.register)
        }

        it("listener routeToRegisterCallCount가 호출이 된다") {
          expect(listener.routeToRegisterCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
        }
      }

      context("현재 로딩중일 경우") {
        beforeEach {
          interactor.action.onNext(.loading(true))
        }

        context("로그인 액션이 발생한 경우") {
          beforeEach {
            interactor.action.onNext(.login)
          }

          it("로그인 요청 이벤트가 발생하지 않는다") {
            expect(authenticationUseCaseMock.loginCallCount).toEventually(equal(0), timeout: TestUtil.Const.timeout)
          }
        }
      }

      context("현재 로딩중이 아닐 경우") {
        beforeEach {
          interactor.action.onNext(.loading(false))
        }

        context("로그인 액션이 발생하여 네트워크가 성공했을 경우") {
          beforeEach {
            authenticationUseCaseMock.networkState = .succeed
            interactor.action.onNext(.login)
          }

          it("온보드 화면으로 이동한다") {
            expect(listener.routeToOnboardCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
          }
        }

        context("로그인 액션이 발생하여 네트워크가 실패했을 경우") {
          beforeEach {
            authenticationUseCaseMock.networkState = .failed
            interactor.action.onNext(.login)
          }

          it("에러메세지가 빈값이 아니다") {
            expect(interactor.currentState.errorMessage).toNotEventually(equal(""), timeout: TestUtil.Const.timeout)
          }

          it("온보딩화면으로 이동하지 않는다") {
            expect(listener.routeToOnboardCallCount).toEventually(equal(0), timeout: TestUtil.Const.timeout)
          }
        }
      }
    }
  }
}
