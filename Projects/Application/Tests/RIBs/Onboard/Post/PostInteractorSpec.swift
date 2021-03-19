import Nimble
import Quick
@testable import Application

class PostInteractorSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: PostInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: PostViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: PostListenerMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var postUseCase: FirebasePostUseCaseMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var userUseCase: FirebaseUserUseCaseMock!

    beforeEach {
      viewController = PostViewControllableMock()
      postUseCase = FirebasePostUseCaseMock()
      userUseCase = FirebaseUserUseCaseMock()
      listener = PostListenerMock()
      interactor = PostInteractor(
        presenter: viewController,
        initialState: .defaultValue(),
        postUseCase: postUseCase,
        userUseCase: userUseCase)
      interactor.listener = listener
    }
    afterEach {
      interactor = nil
      viewController = nil
      postUseCase = nil
      userUseCase = nil
    }

    describe("활성화 이후") {
      beforeEach {
        interactor.activate()
      }
      afterEach {
        interactor.deactivate()
      }

      context("취소 액션이 들어올 경우") {
        beforeEach {
          interactor.action.onNext(.cancel)
        }

        it("리스너 routeToClose 메서드가 불리게 된다") {
          expect(listener.routeToCloseCallCount) == 1
        }
      }

      context("타이핑 액션이 들어올 경우") {
        beforeEach {
          interactor.action.onNext(.typingCaption("test"))
        }

        it("리스너 dismissPost 메서드가 불리게 된다") {
          expect(interactor.currentState.caption).toEventually(equal("test"), timeout: TestUtil.Const.timeout)
        }
      }

      context("현재 로딩중일 경우") {
        beforeEach {
          interactor.action.onNext(.loading(true))
        }

        context("쉐어 액션이 들어올 경우") {
          beforeEach {
            interactor.action.onNext(.share)
          }

          it("리스너 routeToClose 메서드가 불리지 않는다") {
            expect(listener.routeToCloseCallCount) == 0
          }
        }
      }

      context("현재 로딩중이 아닐 경우") {
        beforeEach {
          interactor.action.onNext(.loading(false))
        }

        context("쉐어 액션이 들어오고 또한 userUseCase가 에러가 발생한 경우") {
          beforeEach {
            postUseCase.networkState = .succeed
            userUseCase.networkState = .failed
            interactor.action.onNext(.share)
          }

          it("리스너 routeToClose 메서드가 불리지 않는다") {
            expect(listener.routeToCloseCallCount).toEventually(equal(0), timeout: TestUtil.Const.timeout)
            expect(interactor.currentState.errorMessage).toNotEventually(equal(""), timeout: TestUtil.Const.timeout)
          }
        }

        context("쉐어 액션이 들어오고 또한 postUseCase가 에러가 발생한 경우") {
          beforeEach {
            postUseCase.networkState = .failed
            userUseCase.networkState = .succeed
            interactor.action.onNext(.share)
          }

          it("리스너 routeToClose 메서드가 불리지 않는다") {
            expect(listener.routeToCloseCallCount).toEventually(equal(0), timeout: TestUtil.Const.timeout)
            expect(interactor.currentState.errorMessage).toNotEventually(equal(""), timeout: TestUtil.Const.timeout)
          }
        }

        context("쉐어 액션이 들어오고 또한 postUseCase와 userUseCase 둘다 에러가 발생한 경우") {
          beforeEach {
            postUseCase.networkState = .failed
            userUseCase.networkState = .failed
            interactor.action.onNext(.share)
          }

          it("리스너 routeToClose 메서드가 불리지 않는다") {
            expect(listener.routeToCloseCallCount).toEventually(equal(0), timeout: TestUtil.Const.timeout)
            expect(interactor.currentState.errorMessage).toNotEventually(equal(""), timeout: TestUtil.Const.timeout)
          }
        }

        context("쉐어 액션이 들어오고 또한 postUseCase와 userUseCase 둘다 에러가 발생하지 않을 경우") {
          beforeEach {
            postUseCase.networkState = .succeed
            userUseCase.networkState = .succeed
            interactor.action.onNext(.share)
          }

          it("리스너 routeToClose 메서드가 불린다") {
            expect(listener.routeToCloseCallCount).toEventually(equal(1), timeout: TestUtil.Const.timeout)
            expect(interactor.currentState.errorMessage).toEventually(equal(""), timeout: TestUtil.Const.timeout)
          }
        }
      }
    }
  }
}
