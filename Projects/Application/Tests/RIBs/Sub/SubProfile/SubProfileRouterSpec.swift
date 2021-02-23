import Nimble
import Quick
@testable import Application

class SubProfileRouterSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: SubProfileViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var router: SubProfileRouter!

    beforeEach {
      viewController = SubProfileViewControllableMock()
      router = SubProfileRouter(
        interactor: SubProfileInteractableMock(),
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
