import Nimble
import Quick

@testable import Application

class FeedInteractorSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: FeedInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: FeedViewControllableMock!

    beforeEach {
      viewController = FeedViewControllableMock()
      let state = FeedDisplayModel.State.initialState()
      interactor = FeedInteractor(
        presenter: viewController,
        initialState: state)
      _ = FeedRoutingMock(
        interactable: interactor,
        viewControllable: viewController)
    }
    afterEach {
      interactor = nil
      viewController = nil
    }
  }
}
