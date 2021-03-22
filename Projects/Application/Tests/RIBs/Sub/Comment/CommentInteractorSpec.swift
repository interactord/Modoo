import Nimble
import Quick

@testable import Application

class CommentInteractorSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: CommentInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: CommentViewControllableMock!

    beforeEach {
      viewController = CommentViewControllableMock()
      interactor = CommentInteractor(presenter: viewController)
      _ = CommentRoutingMock(
        interactable: interactor,
        viewControllable: viewController)
    }
    afterEach {
      interactor = nil
      viewController = nil
    }
  }
}
