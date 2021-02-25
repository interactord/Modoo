import Nimble
import Quick

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

    beforeEach {
      viewController = OnboardViewControllableMock()
      listener = OnboardListenerMock()
      interactor = OnboardInteractor(presenter: viewController)
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

      context("포스트 페이지 이동 메서드가 불릴 경우") {
        beforeEach {
          interactor.routeToPost()
        }

        it("router의 routeToPost가 불린다") {
          expect(router.routeToPostCallCount) == 1
        }
      }
    }
  }
}
