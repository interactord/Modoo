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
