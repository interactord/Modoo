import Foundation
import Nimble
import Quick

@testable import Application

class RootViewControllerSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: RootViewController!
    var viewControllableMock: ViewControllableMock!

    beforeEach {
      viewController = RootViewController()
      viewControllableMock = ViewControllableMock()
    }
    afterEach {
      viewController = nil
      viewControllableMock = nil
    }

    describe("OnboardViewController viewLoad 호출시") {
      beforeEach {
        viewController.viewDidLoad()
      }

      context("present 호출시") {
        beforeEach {
          viewController.present(viewController: viewControllableMock)
        }

        it("ing...") {
          expect(viewController).toNot(beNil())
        }
      }
    }
  }
}
