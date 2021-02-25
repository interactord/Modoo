import Nimble
import Quick
@testable import Application

class PostInteractorSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: PostInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: PostViewControllableMock!

    beforeEach {
      viewController = PostViewControllableMock()
      interactor = PostInteractor(presenter: viewController)
      _ = PostRoutingMock(
        interactable: interactor,
        viewControllable: viewController)
    }
    afterEach {
      interactor = nil
      viewController = nil
    }
  }
}
