import Nimble
import Quick
@testable import Application

class RootRouterSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: RootViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var router: RootRouter!

    beforeEach {
      viewController = RootViewControllableMock()
      router = RootRouter(
        interactor: RootInteractableMock(),
        viewController: viewController,
        authenticationBuilder: AuthenticationBuildableMock(),
        onboardBuilder: OnboardBuildableMock())
    }

    describe("RootRouter") {
      context("didLoad 실행시") {
        beforeEach {
          router.didLoad()
        }

        it("viewController presentCallCount는 1이 된다") {
          expect(viewController.presentCallCount) == 1
        }

        context("cleanupViews 실행시") {
          beforeEach {
            router.cleanupViews()
          }

          it("dismissCallCount는 1이다") {
            expect(viewController.dismissCallCount) == 1
          }

          context("cleanupViews 실행시") {
            beforeEach {
              router.cleanupViews()
            }

            it("2번 호출하면 dismissCallCount는 1이다") {
              expect(viewController.dismissCallCount) == 1
            }
          }
        }

        context("routeToLoggedIn 실행시") {
          beforeEach {
            router.routeToLoggedIn()
          }

          it("viewController presentCallCount는 2이다") {
            expect(viewController.presentCallCount) == 2
          }
          it("dismissCallCount는 1이다") {
            expect(viewController.dismissCallCount) == 1
          }
        }

        context("routeToLoggedIn 실행시") {
          beforeEach {
            router.routeToLoggedIn()
          }

          it("viewController presentCallCount는 2이다") {
            expect(viewController.presentCallCount) == 2
          }
          it("viewController dismissCallCount는 1이다") {
            expect(viewController.dismissCallCount) == 1
          }
        }
      }
    }
  }
}
