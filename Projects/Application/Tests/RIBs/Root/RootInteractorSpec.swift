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
    }
    afterEach {
      interactor = nil
      viewController = nil
      router = nil
    }

    describe("RootInteractor activate실행시") {

      beforeEach {
        interactor.activate()
      }

      context("routeToOnboard 실행시") {
        beforeEach {
          interactor.routeToOnboard()
        }

        it("router routeToOnboardCallCount는 1이다") {
          expect(router.routeToOnboardCallCount) == 1
        }
      }

      context("routeToAuthentication 실행시") {
        beforeEach {
          interactor.routeToAuthentication()
        }

        it("router routeToAuthenticationCallCount는 1이다") {
          expect(router.routeToAuthenticationCallCount) == 1
        }
      }

      context("deactivate 실행시") {
        beforeEach {
          interactor.deactivate()
        }

        it("router cleanupViewCallCount는 1이다") {
          expect(router.cleanupViewCallCount) == 1
        }
      }
    }
  }
}
