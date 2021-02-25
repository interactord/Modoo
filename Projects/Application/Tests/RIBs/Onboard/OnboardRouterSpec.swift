import Nimble
import Quick

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
          router.routeToPost()
        }

        it("viewController present메서드가 불린다") {
          expect(viewController.presentCallCount) == 1
        }

        context("routeToPost가 불리면") {
          beforeEach {
            router.routeToPost()
          }

          it("viewController present메서드가 불린다") {
            expect(viewController.presentCallCount) == 2
          }
        }
      }
    }
  }
}
