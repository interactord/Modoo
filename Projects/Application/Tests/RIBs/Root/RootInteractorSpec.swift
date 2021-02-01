import Nimble
import Quick
@testable import Application

class RootInteractorSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: RootInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: RootViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var router: RootRoutingMock!

    beforeEach {
      viewController = RootViewControllableMock()
      interactor = RootInteractor(presenter: viewController)
      router = RootRoutingMock(interactable: interactor, viewControllable: viewController)
      interactor.router = router
      interactor.activate()
    }

    describe("RootInteractor") {
      context("로그인이 되었을 경우") {
        it("attachChildCallCount 가 1이 된다") {
          interactor.didLogin()
          expect(router.attachChildCallCount) == 1
        }
      }

      context("deactivate 될 경우") {
        it("cleanup 메서드가 호출이 된다") {
          interactor.deactivate()
          expect(router.cleanupViewCallCount) == 1
        }
      }
    }
  }
}
