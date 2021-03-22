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

    beforeEach {
      viewController = CommentViewControllableMock()
      let state = CommentDisplayModel.State.defaultValue()
      interactor = CommentInteractor(
        presenter: viewController,
        initialState: state)
      listener = CommentListenerMock()
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
