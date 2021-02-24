import Nimble
import Quick
@testable import Application

class SubProfileInteractorSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: SubProfileInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: SubProfileViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var userUseCaseMock: FirebaseUserUseCaseMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var listenerMock: SubProfileListenerMock!

    beforeEach {
      viewController = SubProfileViewControllableMock()
      userUseCaseMock = FirebaseUserUseCaseMock()
      let state = ProfileDisplayModel.State.initialState()
      listenerMock = SubProfileListenerMock()
      interactor = SubProfileInteractor(
        presenter: viewController,
        initialState: state,
        userUseCase: userUseCaseMock,
        uid: "test")
      interactor.listener = listenerMock
    }
    afterEach {
      interactor = nil
      viewController = nil
      userUseCaseMock = nil
      listenerMock = nil
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
            expect(userUseCaseMock.fetchUserUIDCallCount).toEventually(equal(0), timeout: TestUtil.Const.timeout)
            expect(userUseCaseMock.fetchUserSocialUUIDCallCount).toEventually(equal(0), timeout: TestUtil.Const.timeout)
            expect(userUseCaseMock.isFollowedCallCount).toEventually(equal(0), timeout: TestUtil.Const.timeout)
          }
        }

        context("팔로우 버튼을 눌렀을 경우") {
          beforeEach {
            interactor.action.onNext(.follow)
          }

          it("팔로우 업데이트 이벤트는 발생하지 않는다") {
            expect(userUseCaseMock.followCallCount).toEventually(equal(0), timeout: TestUtil.Const.timeout)
          }
        }

        context("언팔로우 버튼을 눌렀을 경우") {
          beforeEach {
            interactor.action.onNext(.unFollow)
          }

          it("언팔로우 업데이트 이벤트는 발생하지 않는다") {
            expect(userUseCaseMock.unFollowCallCount).toEventually(equal(0), timeout: TestUtil.Const.timeout)
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
            expect(userUseCaseMock.fetchUserUIDCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
            expect(userUseCaseMock.fetchUserSocialUUIDCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
            expect(userUseCaseMock.isFollowedCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
          }

          it("에러 메세지는 빈값이다") {
            expect(interactor.currentState.errorMessage).toEventually(equal(""), timeout: TestUtil.Const.timeout)
          }
        }

        context("유저 정보 요청 네트워크가 실패했을 경우") {
          beforeEach {
            userUseCaseMock.networkState = .failed
            interactor.action.onNext(.load)
          }

          it("유저 정보 요청 이벤트가 발생한다") {
            expect(userUseCaseMock.fetchUserUIDCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
          }

          it("에러 메세지는 빈값이 아니다") {
            expect(interactor.currentState.errorMessage).toNotEventually(equal(""), timeout: TestUtil.Const.timeout)
          }
        }

        context("팔로우 버튼을 눌렀고 네트워크가 성공헀을 경우") {
          beforeEach {
            userUseCaseMock.networkState = .succeed
            interactor.action.onNext(.follow)
          }

          it("팔로우 업데이트 이벤트가 발생한다") {
            expect(userUseCaseMock.followCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
          }

          it("에러 메세지는 빈값이다") {
            expect(interactor.currentState.errorMessage).toEventually(equal(""), timeout: TestUtil.Const.timeout)
          }
        }

        context("팔로우 버튼을 눌렀고 네트워크가 실패헀을 경우") {
          beforeEach {
            userUseCaseMock.networkState = .failed
            interactor.action.onNext(.follow)
          }

          it("팔로우 업데이트 이벤트가 발생한다") {
            expect(userUseCaseMock.followCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
          }

          it("에러 메세지는 빈값이 아니다") {
            expect(interactor.currentState.errorMessage).toNotEventually(equal(""), timeout: TestUtil.Const.timeout)
          }
        }

        context("언팔로우 버튼을 눌렀고 네트워크가 성공헀을 경우") {
          beforeEach {
            userUseCaseMock.networkState = .succeed
            interactor.action.onNext(.unFollow)
          }

          it("언팔로우 업데이트 이벤트가 발생한다") {
            expect(userUseCaseMock.unFollowCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
          }

          it("에러 메세지는 빈값이다") {
            expect(interactor.currentState.errorMessage).toEventually(equal(""), timeout: TestUtil.Const.timeout)
          }
        }

        context("언팔로우 버튼을 눌렀고 네트워크가 실패헀을 경우") {
          beforeEach {
            userUseCaseMock.networkState = .failed
            interactor.action.onNext(.unFollow)
          }

          it("언팔로우 업데이트 이벤트가 발생한다") {
            expect(userUseCaseMock.unFollowCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
          }

          it("에러 메세지는 빈값이 아니다") {
            expect(interactor.currentState.errorMessage).toNotEventually(equal(""), timeout: TestUtil.Const.timeout)
          }
        }
      }

      context("백 버튼 액션이 들어온 경우") {
        beforeEach {
          interactor.action.onNext(.back)
        }

        it("routeToBack 메서드가 불린다") {
          expect(listenerMock.routeToBackCallCount) == 1
        }
      }
    }
  }
}
