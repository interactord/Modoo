import Nimble
import Quick

@testable import Application

class LoginVIewControllerSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: LoginViewController!

    beforeEach {
      viewController = LoginViewController()
    }
    afterEach {
      viewController = nil
    }

    describe("LoginViewController viewLoad 호출시") {
      beforeEach {
        viewController.viewDidLoad()
        viewController.viewDidLayoutSubviews()
      }

      it("ing...") {
        expect(viewController).toNot(beNil())
      }
    }
  }
}
