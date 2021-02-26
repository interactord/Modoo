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
        postBuilder: PostBuildableMock())
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

        context("dismissPost가 불리면") {
          beforeEach {
            router.dismissPost()
          }

          it("viewController dismiss 메서드가 호출된다") {
            expect(viewController.dismissCallCount) == 1
          }
        }
      }

      context("dismissPost가 불리면") {
        beforeEach {
          router.dismissPost()
        }

        it("viewController dismiss 메서드는 불리지 않는다") {
          expect(viewController.dismissCallCount) == 0
        }
      }
    }
  }
}
