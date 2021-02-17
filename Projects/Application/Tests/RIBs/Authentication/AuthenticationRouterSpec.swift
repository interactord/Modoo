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
    afterEach {
      router = nil
      viewController = nil
    }

    describe("AuthenticationRouter didLoad 실행시") {
      beforeEach {
        router.didLoad()
      }

      context("cleanupViews 실행시") {
        beforeEach {
          router.cleanupViews()
        }

        it("viewController popToRootViewControllableCallCount는 0이다") {
          expect(viewController.popToRootViewControllableCallCount) == 0
        }

        it("viewController viewControllers는 1이다") {
          expect(viewController.viewControllers) == 1
        }
      }

      context("routeToLogin 실행시") {
        beforeEach {
          router.routeToLogin()
        }

        it("viewController setRootCallCount는 1이다") {
          expect(viewController.setRootCallCount) == 1
        }

        it("viewController viewControllers는 1이다") {
          expect(viewController.viewControllers) == 1
        }
      }

      context("routeToRegister 실행시") {
        beforeEach {
          router.routeToRegister()
        }

        it("viewController pushCallCount는 1이다") {
          expect(viewController.pushCallCount) == 1
        }

        it("viewController viewControllers는 1이다") {
          expect(viewController.viewControllers) == 2
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
            expect(viewController.viewControllers) == 1
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

        context("routeToLogin 실행시") {
          beforeEach {
            router.routeToLogin()
          }

          it("viewController viewControllers는 1이다") {
            expect(viewController.viewControllers) == 1
          }
        }
      }

      context("routeToRegister 실행시") {
        beforeEach {
          router.routeToRegister()
        }

        context("routeToRegister 실행시") {
          beforeEach {
            router.routeToRegister()
          }

          it("viewController viewControllers는 2이다") {
            expect(viewController.viewControllers) == 2
          }

          it("router childrenRouter의 갯수는 1이다") {
            expect(router.children.count) == 2
          }
        }
      }
    }
  }
}
