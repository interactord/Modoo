import Nimble
import Quick

@testable import Application

class FeedInteractorSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: FeedInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: FeedViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var postUseCase: FirebasePostUseCaseMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var router: FeedRoutingMock!

    beforeEach {
      viewController = FeedViewControllableMock()
      let state = FeedDisplayModel.State.defaultValue()
      postUseCase = FirebasePostUseCaseMock()
      interactor = FeedInteractor(
        presenter: viewController,
        initialState: state,
        postUseCase: postUseCase)
      router = FeedRoutingMock(
        interactable: interactor,
        viewControllable: viewController)
      interactor.router = router
    }
    afterEach {
      interactor = nil
      viewController = nil
      postUseCase = nil
      router = nil
    }

    describe("활성화 이후") {
      beforeEach {
        interactor.activate()
      }
      afterEach {
        interactor.deactivate()
      }

      context("현재 로딩중일 경우") {
        beforeEach {
          interactor.action.onNext(.loading(true))
        }

        context("load 액션이 들어올 경우") {
          beforeEach {
            interactor.action.onNext(.load)
          }

          it("PostUseCase fetchPosts를 호출하지 않는다") {
            expect(postUseCase.fetchPostsCallCount) == 0
          }
        }
      }

      context("현재 로딩중이 아닐 경우") {
        beforeEach {
          interactor.action.onNext(.loading(false))
        }

        context("load 액션이 들어오고 PostUseCase에서 에러가 발생하면") {
          beforeEach {
            postUseCase.networkState = .failed
            interactor.action.onNext(.load)
          }

          it("state error message는 빈값이 아니다") {
            expect(interactor.currentState.errorMessage).toNotEventually(equal(""), timeout: TestUtil.Const.timeout)
          }
        }

        context("load 액션이 들어오고 PostUseCase에서 에러가 발생하지 않는다면") {
          beforeEach {
            postUseCase.networkState = .succeed
            interactor.action.onNext(.load)
          }

          it("state error message는 빈값이다") {
            expect(interactor.currentState.errorMessage).toEventually(equal(""), timeout: TestUtil.Const.timeout)
          }
        }
      }

      context("tabComment 액션이 들어올 경우") {
        beforeEach {
          interactor.action.onNext(.tabComment(.defaultValue()))
        }

        it("라우터의 routeToComment를 호출한다") {
          expect(router.routeToCommentCallCount) == 1
        }
      }
    }
  }
}
