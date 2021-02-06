import Nimble
import Quick

@testable import Application

class RegisterViewControllerSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: RegisterViewController!

    beforeEach {
      viewController = RegisterViewController()
    }
    afterEach {
      viewController = nil
    }

    describe("RegisterViewController viewLoad 호출시") {
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
