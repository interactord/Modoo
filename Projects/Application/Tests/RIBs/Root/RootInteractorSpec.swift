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
      context("routeToLoggedIn 실행시") {
        beforeEach {
          interactor.routeToLoggedIn()
        }

        it("router attachChildCallCount는 1이다") {
          expect(router.attachChildCallCount) == 1
        }
      }

      context("routeToLogin 실행시") {
        beforeEach {
          interactor.routeToLogin()
        }

        it("router attachChildCallCount는 1이다") {
          expect(router.attachChildCallCount) == 1
        }
      }

      context("deactivate 실행시") {
        beforeEach {
          interactor.deactivate()
        }

        it("router cleanupVieRwCallCount는 1이다") {
          expect(router.cleanupViewCallCount) == 1
        }
      }
    }
  }
}
