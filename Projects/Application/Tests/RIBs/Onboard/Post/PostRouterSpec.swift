import Nimble
import Quick
@testable import Application

class PostRouterSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: PostViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var router: PostRouter!

    beforeEach {
      viewController = PostViewControllableMock()
      router = PostRouter(
        interactor: PostInteractableMock(),
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
