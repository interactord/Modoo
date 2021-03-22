import Nimble
import Quick

@testable import Application

class SubFeedInteractorSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: SubFeedInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: SubFeedViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var postUseCase: FirebasePostUseCaseMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: SubFeedListenerMock!

    beforeEach {
      viewController = SubFeedViewControllableMock()
      listener = SubFeedListenerMock()
      postUseCase = FirebasePostUseCaseMock()
      interactor = SubFeedInteractor(
        presenter: viewController,
        initialState: .defaultValue(),
        postUseCase: postUseCase)
      interactor.listener = listener
    }
    afterEach {
      interactor = nil
      viewController = nil
      listener = nil
      postUseCase = nil
    }

    describe("활성화 이후") {
      beforeEach {
        interactor.activate()
      }
      afterEach {
        interactor.deactivate()
      }

      context("클로즈 텝 액션이 발생한 경우") {
        beforeEach {
          interactor.action.onNext(.tapClose)
        }

        it("listener routeToBack가 호출 된다") {
          expect(listener.routeToBackCallCount) == 1
        }
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

        it("listener routeToComment를 호출한다") {

          expect(listener.routeToCommentCallCount) == 1
        }
      }

      context("routeToBackFromComment 메서드가 불리면") {
        beforeEach {
          interactor.routeToBackFromComment()
        }

        it("라우터의 routeToComment 메서드가 불린다") {
          expect(listener.routeToBackFromCommentCallCount) == 1
        }
      }
    }
  }
}
