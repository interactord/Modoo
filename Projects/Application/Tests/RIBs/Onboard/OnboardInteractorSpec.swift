import Nimble
import Quick

@testable import Application

class OnboardInteractorSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable:next implicitly_unwrapped_optional
    var interactor: OnboardInteractor!
    var viewController: OnboardViewControllableMock!
    // swiftlint:disable:previous implicitly_unwrapped_optional

    beforeEach {
      viewController = OnboardViewControllableMock()
      interactor = OnboardInteractor(presenter: viewController)
      _ = OnboardRoutingMock(
        interactable: interactor,
        viewControllable: viewController)
    }

    describe("OnboardInteractor") {}
  }
}
