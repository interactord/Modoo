import Nimble
import Quick

@testable import Application

class CommentRouterSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: CommentViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var router: CommentRouter!

    beforeEach {
      viewController = CommentViewControllableMock()
      router = CommentRouter(
        interactor: CommentInteractableMock(),
        viewController: viewController)
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
