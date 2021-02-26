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

    beforeEach {
      viewController = PostViewControllableMock()
      listener = PostListenerMock()
      interactor = PostInteractor(
        presenter: viewController,
        initialState: .initialState())
      interactor.listener = listener
    }
    afterEach {
      interactor = nil
      viewController = nil
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

        it("리스너 dismissPost 메서드가 불리게 된다") {
          expect(listener.dismissPostCallCount) == 1
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

      context("쉐어 액션이 들어올 경우") {
        beforeEach {
          interactor.action.onNext(.share)
        }

        it("추후작성") {
          expect(interactor.currentState.caption).toEventually(equal(""), timeout: TestUtil.Const.timeout)
        }
      }

      context("로딩중 액션이 들어올 경우") {
        beforeEach {
          interactor.action.onNext(.loading(true))
        }

        it("추후작성") {
          expect(interactor.currentState.isLoading).toEventually(equal(true), timeout: TestUtil.Const.timeout)
        }
      }
    }
  }
}
