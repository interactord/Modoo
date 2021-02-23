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
        subProfileBuilder: SubProfileBuildableMock())
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
