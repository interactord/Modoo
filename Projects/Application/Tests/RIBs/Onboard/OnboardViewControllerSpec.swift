import Nimble
import Quick

@testable import Application

class OnboardViewControllerSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: OnboardViewController!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: OnboardListenerMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var feedTypeViewController: NavigationController!
    // swiftlint:disable implicitly_unwrapped_optional
    var postTypeViewController: NavigationController!
    // swiftlint:disable implicitly_unwrapped_optional
    var selectedResult = false

    beforeEach {
      feedTypeViewController = NavigationController(viewControllerType: .feed, image: nil, unselectedImage: nil, root: EmptyViewController())
      postTypeViewController = NavigationController(viewControllerType: .post, image: nil, unselectedImage: nil, root: EmptyViewController())
      listener = OnboardListenerMock()
      viewController = OnboardViewController()
      viewController.viewControllers = [
        feedTypeViewController,
        postTypeViewController,
      ]
      viewController.listener = listener
    }
    afterEach {
      viewController = nil
      listener = nil
    }

    describe("화면 로드가 완료되면") {
      beforeEach {
        viewController.loadView()
        viewController.viewDidLoad()
      }

      context("feedTypeViewController를 선택했을 경우") {
        beforeEach {
          selectedResult = viewController.tabBarController(viewController, shouldSelect: feedTypeViewController)
        }

        it("selectedResult는 true이며, 화면이 전환이 된다") {
          expect(selectedResult) == true
        }
      }

      context("postTypeViewController를 선택했을 경우") {
        beforeEach {
          selectedResult = viewController.tabBarController(viewController, shouldSelect: postTypeViewController)
        }

        it("selectedResult는 false이며, 화면이 전환이 안된다") {
          expect(selectedResult) == false

        }

        it("listener routeToPost를 호출한다") {
          expect(listener.routeToPostCallCount) == 1
        }
      }
    }
  }
}
