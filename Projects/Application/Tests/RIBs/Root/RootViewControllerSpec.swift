import Nimble
import Quick
import UIKit
@testable import Application

class RootViewControllerSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: RootViewController!

    beforeEach {
      viewController = RootViewController()
    }
    afterEach {
      viewController = nil
    }

    describe("OnboardViewController viewLoad 호출시") {
      beforeEach {
        viewController.viewDidLoad()
      }

      it("viewController는 닐이 아니다") {
        expect(viewController).toNot(beNil())
      }
    }
  }
}
