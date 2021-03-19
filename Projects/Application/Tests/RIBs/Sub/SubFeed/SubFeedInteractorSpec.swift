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
    var listener: SubFeedListenerMock!

    beforeEach {
      viewController = SubFeedViewControllableMock()
      listener = SubFeedListenerMock()
      interactor = SubFeedInteractor(
        presenter: viewController,
        initialState: .defaultValue())
      interactor.listener = listener
    }
    afterEach {
      interactor = nil
      viewController = nil
      listener = nil
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

        it("listener routeToClose가 호출 된다") {
          expect(listener.routeToCloseCallCount) == 1
        }
      }
    }
  }
}
