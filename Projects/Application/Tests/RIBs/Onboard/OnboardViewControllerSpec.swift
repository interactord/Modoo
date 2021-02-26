import Nimble
import Quick
import UIKit

@testable import Application

class OnboardViewControllerSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: OnboardViewController!
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: OnboardInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var feedTypeViewController: NavigationController!
    // swiftlint:disable implicitly_unwrapped_optional
    var postTypeViewController: NavigationController!
    // swiftlint:disable implicitly_unwrapped_optional
    var router: OnboardRoutingMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var postMediaUseCase: YPPostMediaPickerUseCaseMock!
    var selectedResult = false
    let imageMock = UIImage()

    beforeEach {
      feedTypeViewController = NavigationController(viewControllerType: .feed, image: nil, unselectedImage: nil, root: EmptyViewController())
      postTypeViewController = NavigationController(viewControllerType: .post, image: nil, unselectedImage: nil, root: EmptyViewController())
      postMediaUseCase = YPPostMediaPickerUseCaseMock()
      viewController = OnboardViewController(postMediaUseCase: postMediaUseCase)
      viewController.viewControllers = [
        feedTypeViewController,
        postTypeViewController,
      ]
      interactor = OnboardInteractor(
        presenter: viewController,
        initialState: .initialState())
      interactor.isStubEnabled = true
      router = OnboardRoutingMock(interactable: interactor, viewControllable: viewController)
      interactor.router = router
      viewController.listener = interactor
    }
    afterEach {
      viewController = nil
      interactor = nil
      router = nil
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

        context("사진선택이 완료되면") {
          beforeEach {
            postMediaUseCase.image = imageMock
            selectedResult = viewController.tabBarController(viewController, shouldSelect: postTypeViewController)
          }

          it("인터렉션으로 postImage가 전달된다") {
            expect(interactor.stub.actions.last) == OnboardPresentableAction.postImage(imageMock)
          }
        }
      }
    }
  }
}
