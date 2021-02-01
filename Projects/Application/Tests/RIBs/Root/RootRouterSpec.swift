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
        loginBuilder: LoginBuildableMock(),
        onboardBuilder: OnboardBuildableMock())
      router.didLoad()
    }

    describe("RootRouter") {
      context("didLoad 호춣 이후 테스트") {
        it("viewController presentCallCount 기 1이 된다") {
          expect(viewController.presentCallCount) == 1
        }

        context("cleanupViews 테스트") {
          it("1번 호출하면 dismissCallCount 가 1이 된다") {
            router.cleanupViews()
            expect(viewController.dismissCallCount) == 1
          }
          it("2번 호출하면 dismissCallCount 가 1이 된다") {
            router.cleanupViews()
            router.cleanupViews()
            expect(viewController.dismissCallCount) == 1
          }
        }
        it("routeLogin 을 호출하면 viewController presentCallCount 기 2이 된다") {
          router.routeToLoggedIn()
          expect(viewController.presentCallCount) == 2
        }
        it("routeLogin 을 호출하면 viewController dismissCallCount 기 1이 된다") {
          router.routeToLoggedIn()
          expect(viewController.dismissCallCount) == 1
        }
        it("routeOnboard 을 호출하면 viewController presentCallCount 기 2이 된다") {
          router.routeToLoggedIn()
          expect(viewController.presentCallCount) == 2
        }
        it("routeOnboard 을 호출하면 viewController dismissCallCount 기 1이 된다") {
          router.routeToLoggedIn()
          expect(viewController.dismissCallCount) == 1
        }
      }
    }
  }
}
