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
    var userUseCase: FirebaseUserUseCaseMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var postUseCase: FirebasePostUseCaseMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: ProfileListenerMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var router: ProfileRoutingMock!

    beforeEach {
      viewController = ProfileViewControllableMock()
      userUseCase = FirebaseUserUseCaseMock()
      postUseCase = FirebasePostUseCaseMock()
      let state = ProfileDisplayModel.State.defaultValue()
      listener = ProfileListenerMock()
      interactor = ProfileInteractor(
        presenter: viewController,
        initialState: state,
        userUseCase: userUseCase,
        postUseCase: postUseCase)
      router = ProfileRoutingMock(
        interactable: interactor,
        viewControllable: viewController)
      interactor.listener = listener
      interactor.router = router
    }
    afterEach {
      interactor = nil
      viewController = nil
      userUseCase = nil
      postUseCase = nil
      listener = nil
      router = nil
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

          it("유저 정보 요청 이벤트는 발생하지 않는다") {
            expect(userUseCase.fetchUserUIDCallCount).toEventually(equal(0), timeout: TestUtil.Const.timeout)
            expect(userUseCase.fetchUserSocialUIDCallCount).toEventually(equal(0), timeout: TestUtil.Const.timeout)
          }

          it("포스트 정보 요청 이벤트는 발생하지 않는다") {
            expect(postUseCase.fetchPostsForUUIDCallCount).toEventually(equal(0), timeout: TestUtil.Const.timeout)
          }
        }
      }

      context("현재 로딩중이 아닐 경우"){
        beforeEach {
          interactor.action.onNext(.loading(false))
        }

        context("유저 정보 요청 네트워크가 성공했을 경우") {
          beforeEach {
            userUseCase.networkState = .succeed
            interactor.action.onNext(.load)
          }

          it("유저 정보 요청 이벤트가 발생한다") {
            expect(userUseCase.fetchUserUIDCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
            expect(userUseCase.fetchUserSocialUIDCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
          }

          it("포스트 정보 요청 이벤트는 발생한다") {
            expect(postUseCase.fetchPostsForUUIDCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
          }

          it("에러 메세지는 빈값이다") {
            expect(interactor.currentState.errorMessage).toEventually(equal(""), timeout: TestUtil.Const.timeout)
          }
        }
      }

      context("유저 정보 요청 네트워크가 실패했을 경우") {
        beforeEach {
          userUseCase.networkState = .failed
          postUseCase.networkState = .succeed
          interactor.action.onNext(.load)
        }

        it("유저 정보 요청 이벤트가 발생한다") {
          expect(userUseCase.fetchUserUIDCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
          expect(userUseCase.fetchUserSocialUIDCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
        }

        it("포스트 정보 요청 이벤트는 발생한다") {
          expect(postUseCase.fetchPostsForUUIDCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
        }

        it("에러 메세지는 빈값이 아니다") {
          expect(interactor.currentState.errorMessage).toNotEventually(equal(""), timeout: TestUtil.Const.timeout)
        }
      }

      context("포스트 정보 네트워크가 실패했을 경우") {
        beforeEach {
          userUseCase.networkState = .succeed
          postUseCase.networkState = .failed
          interactor.action.onNext(.load)
        }

        it("유저 정보 요청 이벤트가 발생한다") {
          expect(userUseCase.fetchUserUIDCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
          expect(userUseCase.fetchUserSocialUIDCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
        }

        it("포스트 정보 요청 이벤트는 발생한다") {
          expect(postUseCase.fetchPostsForUUIDCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
        }

        it("에러 메세지는 빈값이 아니다") {
          expect(interactor.currentState.errorMessage).toNotEventually(equal(""), timeout: TestUtil.Const.timeout)
        }
      }

      context("로그아웃 액션이 발생한 경우") {
        beforeEach {
          interactor.action.onNext(.logout)
        }

        it("listener의 routeToAuthentication가 불린다") {
          expect(listener.routeToAuthenticationCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
        }
      }

      context("피드 로드 액션이 발생한 경우") {
        beforeEach {
          interactor.action.onNext(.loadPost(.defaultValue()))
        }

        it("router의 routeToSubFeed가 불린다") {
          expect(router.routeToSubFeedCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
        }
      }

      context("메서드 테스트") {
        context("routeToBackFromSubFeed 메서드가 불리면") {
          beforeEach {
            interactor.routeToBackFromSubFeed()
          }

          it("라우터의 routeToBackFromSubFeed 메서드가 불린다") {
            expect(router.routeToBackFromSubFeedCallCount) == 1
          }
        }
      }
    }
  }
}
