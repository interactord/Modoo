import Nimble
import Quick
@testable import Application

class LoginInteractorSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: LoginInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: LoginViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var router: LoginRoutingMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: LoginListenerMock!

    beforeEach {
      viewController = LoginViewControllableMock()
      interactor = LoginInteractor(presenter: viewController)
      router = LoginRoutingMock(interactable: interactor, viewControllable: viewController)
      listener = LoginListenerMock()
      interactor.router = router
      interactor.listener = listener
      interactor.activate()
    }

    describe("LoginInteractor") {

      describe("login 실행시") {
        beforeEach {
          interactor.login()
        }

        it("listener didLoginCallCount는 1이디") {
          expect(listener.didLoginCallCount) == 1
        }
      }
    }
  }
}
