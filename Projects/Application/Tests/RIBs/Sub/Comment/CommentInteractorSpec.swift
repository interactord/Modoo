import Nimble
import Quick

@testable import Application

class CommentInteractorSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: CommentInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: CommentViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: CommentListenerMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var commentUseCase: FirebaseCommentUseCaseMock!

    beforeEach {
      viewController = CommentViewControllableMock()
      let state = CommentDisplayModel.State.defaultValue()
      commentUseCase = FirebaseCommentUseCaseMock()
      interactor = CommentInteractor(
        presenter: viewController,
        initialState: state,
        commentUseCase: commentUseCase)
      listener = CommentListenerMock()
      interactor.listener = listener
    }
    afterEach {
      interactor = nil
      viewController = nil
      commentUseCase = nil
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

          it("commentUseCase fetchComment를 호출하지 않는다") {
            expect(commentUseCase.fetchCommentCallCount) == 0
          }
        }
      }

      context("현재 로딩중일 경우") {
        beforeEach {
          interactor.action.onNext(.loading(false))
        }

        context("load 액션이 불리고 useCase에서 성공적으로 데이터를 가져오는 경우") {
          beforeEach {
            commentUseCase.networkState = .succeed
            interactor.action.onNext(.load)
          }

          it("commentUseCase fetchComment를 호출한다") {
            expect(commentUseCase.fetchCommentCallCount) == 1
          }

          it("현재 에러메세지는 빈값이고 로딩은 false다") {
            expect(interactor.currentState.isLoading).toEventually(equal(false), timeout: TestUtil.Const.timeout)
            expect(interactor.currentState.errorMessage).toEventually(equal(""), timeout: TestUtil.Const.timeout)
          }
        }

        context("load 액션이 불리고 useCase에서 데이터를 가져오는데 에러가 발생한 경우") {
          beforeEach {
            commentUseCase.networkState = .failed
            interactor.action.onNext(.load)
          }

          it("commentUseCase fetchComment를 호출한다") {
            expect(commentUseCase.fetchCommentCallCount) == 1
          }

          it("현재 에러메세지는 빈값이 아니고 로딩은 false다") {
            expect(interactor.currentState.isLoading).toEventually(equal(false), timeout: TestUtil.Const.timeout)
            expect(interactor.currentState.errorMessage).toNotEventually(equal(""), timeout: TestUtil.Const.timeout)
          }
        }
      }

      context("클로즈 텝 액션이 발생한 경우") {
        beforeEach {
          interactor.action.onNext(.back)
        }

        it("listener routeToBackFromComment가 호출 된다") {
          expect(listener.routeToBackFromCommentCallCount) == 1
        }
      }
    }
  }
}
