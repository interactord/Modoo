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
      interactor = SearchInteractor(presenter: viewController)
      _ = SearchRoutingMock(
        interactable: interactor,
        viewControllable: viewController)
    }
    afterEach {
      interactor = nil
      viewController = nil
    }
  }
}
