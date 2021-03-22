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

      it("test..") {
        expect(router).toNot(beNil())
      }
    }
  }
}
