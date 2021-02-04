import Nimble
import Quick

@testable import Application

class AuthenticationViewControllerSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: AuthenticationViewController!

    beforeEach {
      viewController = AuthenticationViewController()
    }
    afterEach {
      viewController = nil
    }

    describe("AuthenticationViewController viewLoad viewDidAppear 호출시") {
      beforeEach {
        viewController.viewDidLoad()
        viewController.viewDidAppear(false)
      }

      it("ing...") {
        expect(viewController).toNot(beNil())
      }
    }
  }
}
