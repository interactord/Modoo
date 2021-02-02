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
        loginBuilder: LoginBuildableMock(),
        registerBuilder: RegisterBuildableMock())
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

      context("routeToLogin 실행시") {
        beforeEach {
          router.routeToLogin()
        }

        it("viewController setRootViewControllerCallCount는 1이다") {
          expect(viewController.setRootViewControllerCallCount) == 1
        }

        it("viewController viewControllers는 1이다") {
          expect(viewController.viewControllers) == 1
        }
      }

      context("routeToRegister 실행시") {
        beforeEach {
          router.routeToRegister()
        }

        it("viewController pushViewControllerCallCount는 1이다") {
          expect(viewController.pushViewControllerCallCount) == 1
        }

        it("viewController viewControllers는 1이다") {
          expect(viewController.viewControllers) == 1
        }
      }

      // MARK: 통합 테스트

      context("routeToLogin 실행시") {
        beforeEach {
          router.routeToLogin()
        }

        context("cleanupViews 실행시") {
          beforeEach {
            router.cleanupViews()
          }

          it("viewController viewControllers는 0이다") {
            expect(viewController.viewControllers) == 0
          }
        }

        context("routeToRegister 실행시") {
          beforeEach {
            router.routeToRegister()
          }

          it("viewController viewControllers는 2이다") {
            expect(viewController.viewControllers) == 2
          }
        }
      }
    }
  }
}
