import Nimble
import Quick
import UIKit

@testable import Application

class OnboardInteractorSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: OnboardInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: OnboardViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: OnboardListenerMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var router: OnboardRoutingMock!
    let imageMock = UIImage()

    beforeEach {
      viewController = OnboardViewControllableMock()
      listener = OnboardListenerMock()
      let state = OnboardDisplayModel.State.initialState()
      interactor = OnboardInteractor(presenter: viewController, initialState: state)
      router = OnboardRoutingMock(
        interactable: interactor,
        viewControllable: viewController)
      interactor.listener = listener
      interactor.router = router
    }
    afterEach {
      interactor = nil
      viewController = nil
      interactor = nil
      router = nil
    }

    describe("활성화가 된 이후") {
      beforeEach {
        interactor.activate()
      }

      context("로그인 페이지 이동 메서드가 불릴 경우") {
        beforeEach {
          interactor.routeToAuthentication()
        }

        it("listener의 routeToAuthentication가 불린다") {
          expect(listener.routeToAuthenticationCallCount) == 1
        }
      }

      context("포스트 이미지가 전달될 경우") {
        beforeEach {
          interactor.action.onNext(.postImage(imageMock))
        }

        it("라우터로 포스트페이지 이동 요청을 한다") {
          expect(router.routeToPostCallCount) == 1
        }
      }

      context("dismissPost 메서드가 불리면") {
        beforeEach {
          interactor.dismissPost()
        }

        it("router dismissPost 호출 한다") {
          expect(router.dismissPostCallCount) == 1
        }
      }

      context("routeToSubFeed가 불리면") {
        beforeEach {
          interactor.routeToSubFeed()
        }

        it("router routeToSubFeed메서드가 불린다") {
          expect(router.routeToSubFeedCallCount) == 1
        }
      }
    }
  }
}
