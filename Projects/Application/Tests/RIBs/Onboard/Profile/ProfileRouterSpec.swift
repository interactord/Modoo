import Nimble
import Quick
@testable import Application

class ProfileRouterSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: ProfileViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var router: ProfileRouter!

    beforeEach {
      viewController = ProfileViewControllableMock()
      router = ProfileRouter(
        interactor: ProfileInteractableMock(),
        viewController: viewController,
        subFeedBuilder: SubFeedBuildableMock())
    }
    afterEach {
      viewController = nil
      router = nil
    }

    describe("로드가 완료되면") {
      beforeEach {
        router.didLoad()
      }

      context("routeToBack 메서드 호출 시") {
        beforeEach {
          router.routeToBackFromSubFeed()
        }

        it("viewController pop 메서드가 불리지 않는다") {
          expect(viewController.popCallCount) == 0
        }
      }

      context("routeToSubFeed 메서드 호출 시") {
        beforeEach {
          router.routeToSubFeed(model: .defaultValue())
        }

        it("viewController push 메서드를 호출 한다") {
          expect(viewController.pushCallCount) == 1
          expect(viewController.viewControllers) == 1
        }

        context("routeToSubFeed 중복 메서드 호출 시") {
          beforeEach {
            router.routeToSubFeed(model: .defaultValue())
          }

          it("viewController push 메서드를 하지 않는다") {
            expect(viewController.pushCallCount) == 1
            expect(viewController.viewControllers) == 1
          }
        }

        context("routeToBackFromSubFeed 메서드 호출 시") {
          beforeEach {
            router.routeToBackFromSubFeed()
          }

          it("viewController pop 메서드가 불린다") {
            expect(viewController.popCallCount) == 1
          }
        }
      }
    }
  }
}
