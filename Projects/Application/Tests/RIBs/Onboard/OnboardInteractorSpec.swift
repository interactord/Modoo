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
    var listenerMock: OnboardListenerMock!

    beforeEach {
      viewController = OnboardViewControllableMock()
      listenerMock = OnboardListenerMock()
      interactor = OnboardInteractor(presenter: viewController)
      _ = OnboardRoutingMock(
        interactable: interactor,
        viewControllable: viewController)
      interactor.listener = listenerMock
    }
    afterEach {
      interactor = nil
      viewController = nil
      listenerMock = nil
    }

    describe("로그인 페이지 이동 메서드가 불릴 경우") {
      beforeEach {
        interactor.routeToAuthentication()
      }

      it("listMock의 routeToAuthenticationCallCount는 1이 된다") {
        expect(listenerMock.routeToAuthenticationCallCount) == 1
      }
    }
  }
}
