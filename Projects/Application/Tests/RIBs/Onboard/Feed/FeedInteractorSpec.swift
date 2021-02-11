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
      interactor = FeedInteractor(presenter: viewController)
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
