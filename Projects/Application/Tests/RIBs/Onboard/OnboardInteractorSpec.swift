import Nimble
import Quick

@testable import Application

class OnboardInteractorSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: OnboardInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: OnboardViewControllableMock!

    beforeEach {
      viewController = OnboardViewControllableMock()
      interactor = OnboardInteractor(presenter: viewController)
      _ = OnboardRoutingMock(
        interactable: interactor,
        viewControllable: viewController)
    }
    afterEach {
      interactor = nil
      viewController = nil
    }

    describe("OnboardInteractor") {
    }
  }
}
