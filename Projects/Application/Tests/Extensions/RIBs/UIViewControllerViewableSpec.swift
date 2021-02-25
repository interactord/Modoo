import Nimble
import Quick
import RIBs
@testable import Application

class UIViewControllerViewableSpec: QuickSpec {

  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: UIViewControllerViewableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var navigationController: UINavigationControllerViewableMock!

    beforeEach {
      viewController = UIViewControllerViewableMock()
      navigationController = UINavigationControllerViewableMock()
    }
    afterEach {
      viewController = nil
      navigationController = nil
    }

    describe("navigationController 기능 테스트") {
      context("present와 dismiss 메서드가 불리면") {
        beforeEach {
          navigationController.present(viewControllable: viewController, isFullScreenSize: true, animated: false)
          navigationController.dismiss(viewControllable: viewController, animated: false)
        }

        it("navigationController의 present 그리고 viewController dimiss 메서드가 불린다") {
          expect(navigationController.presentCallCount) == 1
          expect(viewController.dismissCallCount) == 1
        }
      }

      context("psuh와 pop 메서드가 불리면") {
        beforeEach {
          navigationController.push(viewControllable: viewController, animated: false)
          navigationController.pop(viewControllable: viewController, animated: false)
        }

        it("navigationController와 popViewController 메서드가 불린다") {
          expect(navigationController.pushViewControllerCallCount) == 1
          expect(navigationController.popViewControllerCallCount) == 1
        }
      }

      context("setRoot 메서드가 불리면") {
        beforeEach {
          navigationController.setRoot(viewControllable: viewController, animated: false)
        }

        it("navigationController와 setViewControllers 메서드가 불린다") {
          expect(navigationController.setViewControllersCallCount) == 1
        }
      }

      context("popToRootViewControllable 메서드가 불리면") {
        beforeEach {
          navigationController.popToRootViewControllable(animated: false)
        }

        it("navigationController와 popToRootViewController 메서드가 불린다") {
          expect(navigationController.popToRootViewControllerCallCount) == 1
        }
      }

      context("clearRootViewControllable 메서드가 불리면") {
        beforeEach {
          navigationController.clearRootViewControllable(animated: false)
        }

        it("navigationController와 popToRootViewController 메서드가 불린다") {
          expect(navigationController.setViewControllersCallCount) == 1
        }
      }
    }

    describe("viewController 기능 테스트") {
      context("nvigationController의 setViewControllers먼저 호출하여 세팅한다") {
        beforeEach {
          navigationController.setViewControllers([viewController], animated: false)
        }

        it("navigationController와 popToRootViewController 메서드가 불린다") {
          expect(navigationController.setViewControllersCallCount) == 1
        }

        context("present와 dismiss 메서드가 불리면") {
          beforeEach {
            viewController.present(viewControllable: UIViewControllerViewableMock(), isFullScreenSize: true, animated: false)
            viewController.dismiss(viewControllable: viewController, animated: false)
          }

          it("present 그리고 dimiss 메서드가 불린다") {
            expect(viewController.presentCallCount) == 1
            expect(viewController.dismissCallCount) == 1
          }
        }

        context("push와 pop 메서드가 불리면") {
          beforeEach {
            viewController.push(viewControllable: UIViewControllerViewableMock(), animated: false)
            viewController.pop(viewControllable: viewController, animated: false)
          }

          it("navigationController의 popViewController 그리고 popViewControllerCallCount 메서드가 불린다") {
            expect(navigationController.pushViewControllerCallCount) == 1
            expect(navigationController.popViewControllerCallCount) == 1
          }
        }

        context("setRoot 메서드가 불리면") {
          beforeEach {
            viewController.setRoot(viewControllable: viewController, animated: false)
          }

          it("navigationController의 setViewControllers 메서드가 불린다") {
            expect(navigationController.setViewControllersCallCount) == 2
          }
        }

        context("popToRootViewControllable 메서드가 불리면") {
          beforeEach {
            viewController.popToRootViewControllable(animated: false)
          }

          it("navigationController와 popToRootViewController 메서드가 불린다") {
            expect(navigationController.popToRootViewControllerCallCount) == 1
          }
        }

        context("clearRootViewControllable 메서드가 불리면") {
          beforeEach {
            viewController.clearRootViewControllable(animated: false)
          }

          it("navigationController와 popToRootViewController 메서드가 불린다") {
            expect(navigationController.setViewControllersCallCount) == 2
          }
        }
      }
    }
  }
}
