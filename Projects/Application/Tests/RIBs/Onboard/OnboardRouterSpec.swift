import Nimble
import Quick

@testable import Application

class OnboardRouterSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: OnboardViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var router: OnboardRouter!

    beforeEach {
      viewController = OnboardViewControllableMock()
      router = OnboardRouter(
        interactor: OnboardInteractableMock(),
        viewController: viewController)
      router.didLoad()
    }

    describe("OnboardRouter") {}
  }
}
