import Nimble
import Quick
import UIKit

@testable import Application

class OnboardRouterSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: OnboardViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var router: OnboardRouter!

    beforeEach {
      viewController = OnboardViewControllableMock()
      router = OnboardRouter(
        interactor: OnboardInteractableMock(),
        viewController: viewController,
        feedBuilder: FeedBuildableMock(),
        profileBuilder: ProfileBuildableMock(),
        searchBuilder: SearchBuildableMock(),
        postBuilder: PostBuildableMock(),
        commentBuilder: CommentBuildableMock())
    }
    afterEach {
      viewController = nil
      router = nil
    }

    describe("로드가 완료되면") {
      beforeEach {
        router.didLoad()
      }

      context("routeToPost가 불리면") {
        beforeEach {
          router.routeToPost(image: UIImage())
        }

        it("viewController present메서드가 불린다") {
          expect(viewController.presentCallCount) == 1
        }

        context("routeToPost가 불리면") {
          beforeEach {
            router.routeToPost(image: UIImage())
          }

          it("viewController present메서드가 불린다") {
            expect(viewController.presentCallCount) == 2
          }
        }

        context("routeToClose가 불리면") {
          beforeEach {
            router.routeToClose()
          }

          it("viewController dismiss 메서드가 호출된다") {
            expect(viewController.dismissCallCount) == 2
          }
        }
      }

      context("routeToClose가 불리면") {
        beforeEach {
          router.routeToClose()
        }

        it("viewController dismiss 메서드가 호출된다") {
          expect(viewController.dismissCallCount) == 1
        }
      }

      context("routeToComment가 불리면") {
        beforeEach {
          router.routeToComment(item: .defaultValue())
        }

        it("viewController push 메서드가 호출된다") {
          expect(viewController.pushCallCount) == 1
        }
      }

      context("routeToClose가 불리면") {
        beforeEach {
          router.routeToClose()
        }

        it("viewController dismiss 메서드가 호출된다") {
          expect(viewController.dismissCallCount) == 1
        }
      }

      context("routeToComment 메서드 호출 시") {
        beforeEach {
          router.routeToComment(item: .defaultValue())
        }

        it("viewController push 메서드를 호출 한다") {
          expect(viewController.pushCallCount) == 1
          expect(viewController.viewControllers) == 1
        }

        context("routeToComment 중복 메서드 호출 시") {
          beforeEach {
            router.routeToComment(item: .defaultValue())
          }

          it("viewController push 메서드를 하지 않는다") {
            expect(viewController.pushCallCount) == 1
            expect(viewController.viewControllers) == 1
          }
        }

        context("routeToBackFromComment 메서드 호출 시") {
          beforeEach {
            router.routeToBackFromComment()
          }

          it("viewController pop 메서드가 불린다") {
            expect(viewController.popCallCount) == 1
          }
        }
      }

      context("routeToBackFromComment 메서드 호출 시") {
        beforeEach {
          router.routeToBackFromComment()
        }

        it("viewController pop 메서드가 불리지 않는다") {
          expect(viewController.popCallCount) == 0
        }
      }
    }
  }
}
