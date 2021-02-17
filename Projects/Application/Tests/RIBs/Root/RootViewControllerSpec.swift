import Nimble
import Quick
import UIKit
@testable import Application

class RootViewControllerSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: RootViewControllerSpy!
    var viewControllableMock: ViewControllableMock!

    beforeEach {
      viewController = RootViewControllerSpy()
      viewControllableMock = ViewControllableMock()

      let window = UIWindow(frame: UIScreen.main.bounds)
      window.makeKeyAndVisible()
      window.rootViewController = viewController
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
          viewController.present(viewControllable: viewControllableMock, animated: false)
        }

        it("presentViewControllerTarget는 nil이 아니다") {
          expect(viewController.presentViewControllerTarget).toNot(beNil())
        }
      }

      context("setRoot 호출시") {
        beforeEach {
          viewController.setRoot(viewControllable: viewControllableMock, animated: false)
        }

        it("viewControllers count는 1이다") {
          expect(viewController.viewControllers.count) == 1
        }
      }

      context("clearRootViewControllable 호출시") {
        beforeEach {
          viewController.clearRootViewControllable(animated: false)
        }

        it("viewControllers count는 0이다") {
          expect(viewController.viewControllers.count) == 0
        }
      }

      context("이미 viewControllableMock가 present가 되었을 경우") {
        beforeEach {
          viewController.present(viewControllable: viewControllableMock, animated: false)
        }

        context("동일한 주소값의 viewControllableMock로 dismiss 호출시") {
          beforeEach {
            viewController.dismiss(viewControllable: viewControllableMock, animated: false)
          }

          it("presentViewControllerTarget는 nil이다") {
            expect(viewController.presentViewControllerTarget).to(beNil())
          }
        }

        context("동일한 다른 주소값의 viewControllableMock로 dismiss 호출시") {
          beforeEach {
            viewController.dismiss(viewControllable: ViewControllableMock(), animated: false)
          }

          it("presentationController는 nil이 아니다") {
            expect(viewController.presentViewControllerTarget).toNot(beNil())
          }
        }
      }
    }
  }
}
