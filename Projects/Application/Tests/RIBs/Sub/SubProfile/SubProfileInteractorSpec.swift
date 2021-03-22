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
    var userUseCase: FirebaseUserUseCaseMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var postUseCase: FirebasePostUseCaseMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: SubProfileListenerMock!

    beforeEach {
      viewController = SubProfileViewControllableMock()
      userUseCase = FirebaseUserUseCaseMock()
      postUseCase = FirebasePostUseCaseMock()
      let state = SubProfileDisplayModel.State.defaultValue()
      listener = SubProfileListenerMock()
      interactor = SubProfileInteractor(
        presenter: viewController,
        initialState: state,
        userUseCase: userUseCase,
        postUseCase: postUseCase,
        uid: "test")
      interactor.listener = listener
    }
    afterEach {
      interactor = nil
      viewController = nil
      userUseCase = nil
      postUseCase = nil
      listener = nil
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
            expect(userUseCase.fetchUserUIDCallCount).toEventually(equal(0), timeout: TestUtil.Const.timeout)
            expect(userUseCase.fetchUserSocialUIDCallCount).toEventually(equal(0), timeout: TestUtil.Const.timeout)
            expect(userUseCase.isFollowedCallCount).toEventually(equal(0), timeout: TestUtil.Const.timeout)
          }

          it("포스트 정보 요청 이벤트는 발생하지 않는다") {
            expect(postUseCase.fetchPostsForUUIDCallCount).toEventually(equal(0), timeout: TestUtil.Const.timeout)
          }
        }

        context("팔로우 버튼을 눌렀을 경우") {
          beforeEach {
            interactor.action.onNext(.follow)
          }

          it("팔로우 업데이트 이벤트는 발생하지 않는다") {
            expect(userUseCase.followCallCount).toEventually(equal(0), timeout: TestUtil.Const.timeout)
          }
        }

        context("언팔로우 버튼을 눌렀을 경우") {
          beforeEach {
            interactor.action.onNext(.unFollow)
          }

          it("언팔로우 업데이트 이벤트는 발생하지 않는다") {
            expect(userUseCase.unFollowCallCount).toEventually(equal(0), timeout: TestUtil.Const.timeout)
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

          it("에러 메세지는 빈값이다") {
            expect(interactor.currentState.errorMessage).toEventually(equal(""), timeout: TestUtil.Const.timeout)
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
          }

          it("포스트 정보 요청 이벤트는 발생한다") {
            expect(postUseCase.fetchPostsForUUIDCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
          }

          it("에러 메세지는 빈값이 아니다") {
            expect(interactor.currentState.errorMessage).toNotEventually(equal(""), timeout: TestUtil.Const.timeout)
          }
        }

        context("유저 정보 요청 네트워크가 실패했을 경우") {
          beforeEach {
            userUseCase.networkState = .succeed
            postUseCase.networkState = .failed
            interactor.action.onNext(.load)
          }

          it("유저 정보 요청 이벤트가 발생한다") {
            expect(userUseCase.fetchUserUIDCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
          }

          it("포스트 정보 요청 이벤트는 발생한다") {
            expect(postUseCase.fetchPostsForUUIDCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
          }

          it("에러 메세지는 빈값이 아니다") {
            expect(interactor.currentState.errorMessage).toNotEventually(equal(""), timeout: TestUtil.Const.timeout)
          }
        }

        context("팔로우 버튼을 눌렀고 네트워크가 성공헀을 경우") {
          beforeEach {
            userUseCase.networkState = .succeed
            interactor.action.onNext(.follow)
          }

          it("팔로우 업데이트 이벤트가 발생한다") {
            expect(userUseCase.followCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
          }

          it("에러 메세지는 빈값이다") {
            expect(interactor.currentState.errorMessage).toEventually(equal(""), timeout: TestUtil.Const.timeout)
          }
        }

        context("팔로우 버튼을 눌렀고 네트워크가 실패헀을 경우") {
          beforeEach {
            userUseCase.networkState = .failed
            interactor.action.onNext(.follow)
          }

          it("팔로우 업데이트 이벤트가 발생한다") {
            expect(userUseCase.followCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
          }

          it("에러 메세지는 빈값이 아니다") {
            expect(interactor.currentState.errorMessage).toNotEventually(equal(""), timeout: TestUtil.Const.timeout)
          }
        }

        context("언팔로우 버튼을 눌렀고 네트워크가 성공헀을 경우") {
          beforeEach {
            userUseCase.networkState = .succeed
            interactor.action.onNext(.unFollow)
          }

          it("언팔로우 업데이트 이벤트가 발생한다") {
            expect(userUseCase.unFollowCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
          }

          it("에러 메세지는 빈값이다") {
            expect(interactor.currentState.errorMessage).toEventually(equal(""), timeout: TestUtil.Const.timeout)
          }
        }

        context("언팔로우 버튼을 눌렀고 네트워크가 실패헀을 경우") {
          beforeEach {
            userUseCase.networkState = .failed
            interactor.action.onNext(.unFollow)
          }

          it("언팔로우 업데이트 이벤트가 발생한다") {
            expect(userUseCase.unFollowCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
          }

          it("에러 메세지는 빈값이 아니다") {
            expect(interactor.currentState.errorMessage).toNotEventually(equal(""), timeout: TestUtil.Const.timeout)
          }
        }
      }

      context("피드 로드 액션이 발생한 경우") {
        beforeEach {
          interactor.action.onNext(.loadPost(.defaultValue()))
        }

        it("router의 routeToSubFeed가 불린다") {
          expect(listener.routeToSubFeedCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
        }
      }

      context("백 버튼 액션이 들어온 경우") {
        beforeEach {
          interactor.action.onNext(.back)
        }

        it("routeToBack 메서드가 불린다") {
          expect(listener.routeToBackCallCount) == 1
        }
      }
    }
  }
}
