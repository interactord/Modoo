import Nimble
import Quick
@testable import Application

class ProfileInteractorSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: ProfileInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: ProfileViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var userUseCaseMock: FirebaseUserUseCaseMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var listenerMock: ProfileListenerMock!

    beforeEach {
      viewController = ProfileViewControllableMock()
      userUseCaseMock = FirebaseUserUseCaseMock()
      let state = ProfileDisplayModel.State.initialState()
      listenerMock = ProfileListenerMock()
      interactor = ProfileInteractor(
        presenter: viewController,
        initialState: state,
        userUseCase: userUseCaseMock)
      interactor.listener = listenerMock
    }
    afterEach {
      interactor = nil
      viewController = nil
      userUseCaseMock = nil
    }

    describe("활성화 이후") {
      beforeEach {
        interactor.activate()
      }
      afterEach {
        interactor.deactivate()
      }

      context("현재 로딩중일 경우"){
        beforeEach {
          interactor.action.onNext(.loading(true))
        }

        context("로드 액션이 발생한 경우") {
          beforeEach {
            interactor.action.onNext(.load)
          }

          it("유저 정보 요청을 이벤트는 발생하지 않는다") {
            expect(userUseCaseMock.fetchUserCallCount).toEventually(equal(0), timeout: TestUtil.Const.timeout)
          }
        }
      }

      context("현재 로딩중이 아닐 경우"){
        beforeEach {
          interactor.action.onNext(.loading(false))
        }

        context("유저 정보 요청 네트워크가 성공했을 경우") {
          beforeEach {
            userUseCaseMock.networkState = .succeed
            interactor.action.onNext(.load)
          }

          it("유저 정보 요청 이벤트가 발생한다") {
            expect(userUseCaseMock.fetchUserCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
          }

          it("에러 메세지는 빈값이다") {
            expect(interactor.currentState.errorMessage).toEventually(equal(""), timeout: TestUtil.Const.timeout)
          }
        }
      }

      context("유저 정보 요청 네트워크가 실패했을 경우") {
        beforeEach {
          userUseCaseMock.networkState = .failed
          interactor.action.onNext(.load)
        }

        it("유저 정보 요청 이벤트가 발생한다") {
          expect(userUseCaseMock.fetchUserCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
        }

        it("에러 메세지는 빈값이 아니다") {
          expect(interactor.currentState.errorMessage).toNotEventually(equal(""), timeout: TestUtil.Const.timeout)
        }
      }

      context("로그아웃 액션이 발생한 경우") {
        beforeEach {
          interactor.action.onNext(.logout)
        }

        it("listMock의 routeToAuthenticationCallCount는 1이 된다") {
          expect(listenerMock.routeToAuthenticationCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
        }
      }
    }
  }
}
