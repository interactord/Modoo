import Nimble
import Quick
@testable import Application

class SearchRouterSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: SearchViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var router: SearchRouter!

    beforeEach {
      viewController = SearchViewControllableMock()
      router = SearchRouter(
        interactor: SearchInteractableMock(),
        viewController: viewController,
        subProfileBuilder: SubProfileBuildableMock(),
        subFeedBuilder: SubFeedBuildableMock(),
        commentBuilder: CommentBuildableMock())
    }
    afterEach {
      viewController = nil
      router = nil
    }

    describe("로드가 완료되면") {
      beforeEach {
        router.didLoad()
      }

      context("routeToSubProfile 메서드 호출 시") {
        beforeEach {
          router.routeToSubProfile(uid: "testUID")
        }

        it("viewController push 메서드를 호출 한다") {
          expect(viewController.pushCallCount) == 1
          expect(viewController.viewControllers) == 1
        }

        context("routeToSubProfile 중복 메서드 호출 시") {
          beforeEach {
            router.routeToSubProfile(uid: "testTestUID")
          }

          it("viewController push 메서드를 하지 않는다") {
            expect(viewController.pushCallCount) == 1
            expect(viewController.viewControllers) == 1
          }
        }

        context("routeToBackFromSubProfile 메서드 호출 시") {
          beforeEach {
            router.routeToBackFromSubProfile()
          }

          it("viewController pop 메서드가 불린다") {
            expect(viewController.popCallCount) == 1
          }
        }
      }

      context("routeToBack 메서드 호출 시") {
        beforeEach {
          router.routeToBackFromSubFeed()
          router.routeToBackFromSubProfile()
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

        context("routeToComment 메서드 호출 시") {
          beforeEach {
            router.routeToComment(item: .defaultValue())
          }

          it("viewController push 메서드를 호출 한다") {
            expect(viewController.pushCallCount) == 2
            expect(viewController.viewControllers) == 2
          }
        }
      }
    }
  }
}
