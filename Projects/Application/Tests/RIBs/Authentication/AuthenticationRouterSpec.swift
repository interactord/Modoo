import Nimble
import Quick

@testable import Application

class AuthenticationRouterSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: AuthenticationViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var router: AuthenticationRouter!

    beforeEach {
      viewController = AuthenticationViewControllableMock()
      router = AuthenticationRouter(
        interactor: AuthenticationInteractableMock(),
        viewController: viewController,
        loginBuilder: LoginBuildableMock())
    }

    describe("AuthenticationRouter") {
      context("cleanupViews 실행시") {
        beforeEach {
          router.cleanupViews()
        }

        it("viewController clearChildViewControllersCallCount는 1이다") {
          expect(viewController.clearChildViewControllersCallCount) == 1
        }

        it("viewController viewControllers는 0이다") {
          expect(viewController.viewControllers) == 0
        }
      }

      context("routeLogin 실행시") {
        beforeEach {
          router.routeLogin()
        }

        it("viewController setRootViewControllerCallCount는 1이다") {
          expect(viewController.setRootViewControllerCallCount) == 1
        }

        it("viewController viewControllers는 1이다") {
          expect(viewController.viewControllers) == 1
        }
      }

      context("routeLogin 실행시") {
        beforeEach {
          router.routeLogin()
        }

        context("cleanupViews 실행시") {
          beforeEach {
            router.cleanupViews()
          }

          it("viewController viewControllers는 0이다") {
            expect(viewController.viewControllers) == 0
          }
        }
      }
    }
  }
}
