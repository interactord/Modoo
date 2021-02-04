import Nimble
import Quick

@testable import Application

class OnboardViewControllerSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: OnboardViewController!

    beforeEach {
      viewController = OnboardViewController()
    }
    afterEach {
      viewController = nil
    }

    describe("OnboardViewController viewLoad 호출시") {
      beforeEach {
        viewController.viewDidLoad()
      }

      it("ing...") {
        expect(viewController).toNot(beNil())
      }
    }
  }
}
