import Nimble
import Quick

@testable import Application

class SubFeedRouterSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: SubFeedViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var router: SubFeedRouter!

    beforeEach {
      viewController = SubFeedViewControllableMock()
      router = SubFeedRouter(
        interactor: SubFeedInteractableMock(),
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

      it("test...") {
        expect(router).notTo(beNil())
      }
    }
  }
}
