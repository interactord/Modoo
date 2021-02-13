import Nimble
import Quick
@testable import Application

class ProfileInteractorSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: ProfileInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: ProfileViewControllableMock!

    beforeEach {
      viewController = ProfileViewControllableMock()
      interactor = ProfileInteractor(presenter: viewController)
      _ = ProfileRoutingMock(
        interactable: interactor,
        viewControllable: viewController)
    }
    afterEach {
      interactor = nil
      viewController = nil
    }
  }
}
