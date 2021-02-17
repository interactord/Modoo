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

      context("setRoot 메서드가 호출 되면") {
        beforeEach {
          viewController.setRoot(viewControllable: ViewControllableMock(), animated: false)
        }

        it("네비게이션의 서브뷰컨트롤러는 1개가 된다") {
          expect(viewController.viewControllers.count) == 1
        }
      }

      context("push 메서드가 호출 되면") {
        beforeEach {
          viewController.push(viewControllable: ViewControllableMock(), animated: false)
        }

        it("네비게이션의 서브뷰컨트롤러는 1개가 된다") {
          expect(viewController.viewControllers.count) == 1
        }
      }

      context("popToRootViewControllable 메서드가 호출 되면") {
        beforeEach {
          viewController.popToRootViewControllable(animated: false)
        }

        it("네비게이션의 서브뷰컨트롤러는 1개가 된다") {
          expect(viewController.viewControllers.count) == 0
        }
      }
    }
  }
}
