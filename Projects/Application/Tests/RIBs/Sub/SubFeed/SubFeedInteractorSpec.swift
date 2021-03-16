import Nimble
import Quick

@testable import Application

class SubFeedInteractorSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: SubFeedInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: SubFeedViewControllableMock!

    beforeEach {
      viewController = SubFeedViewControllableMock()
      interactor = SubFeedInteractor(presenter: viewController)
      _ = SubFeedRoutingMock(
        interactable: interactor,
        viewControllable: viewController)
    }
    afterEach {
      interactor = nil
      viewController = nil
    }
  }
}
