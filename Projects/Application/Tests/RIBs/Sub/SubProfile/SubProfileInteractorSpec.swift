import Nimble
import Quick
@testable import Application

class SubProfileInteractorSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: SubProfileInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: SubProfileViewControllableMock!

    beforeEach {
      viewController = SubProfileViewControllableMock()
      interactor = SubProfileInteractor(presenter: viewController)
      _ = SubProfileRoutingMock(
        interactable: interactor,
        viewControllable: viewController)
    }
    afterEach {
      interactor = nil
      viewController = nil
    }
  }
}
