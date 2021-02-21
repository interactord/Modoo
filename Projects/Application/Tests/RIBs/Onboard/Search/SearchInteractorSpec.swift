import Nimble
import Quick
@testable import Application

class SearchInteractorSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: SearchInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: SearchViewControllableMock!

    beforeEach {
      viewController = SearchViewControllableMock()
      let state = SearchDisplayModel.State.initialState()
      interactor = SearchInteractor(
        presenter: viewController,
        initialState: state)
      _ = SearchRoutingMock(
        interactable: interactor,
        viewControllable: viewController)
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

      context("현재 로딩중일 경우") {
        beforeEach {
          interactor.action.onNext(.loading(true))
        }

        it("state isLoading은 true이다") {
          expect(interactor.currentState.isLoading) == true
        }
      }
    }
  }
}
