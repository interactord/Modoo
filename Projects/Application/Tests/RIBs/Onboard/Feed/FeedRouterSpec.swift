import Nimble
import Quick

@testable import Application

class FeedRouterSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: FeedViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var router: FeedRouter!

    beforeEach {
      viewController = FeedViewControllableMock()
      router = FeedRouter(
        interactor: FeedInteractableMock(),
        viewController: viewController,
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

      context("routeToComment 메서드 호출 시") {
        beforeEach {
          router.routeToComment(item: .defaultValue())
        }

        it("viewController push 메서드를 호출 한다") {
          expect(viewController.pushCallCount) == 1
          expect(viewController.viewControllers) == 1
        }

        context("routeToComment 중복 메서드 호출 시") {
          beforeEach {
            router.routeToComment(item: .defaultValue())
          }

          it("viewController push 메서드를 하지 않는다") {
            expect(viewController.pushCallCount) == 1
            expect(viewController.viewControllers) == 1
          }
        }
      }
    }
  }
}
