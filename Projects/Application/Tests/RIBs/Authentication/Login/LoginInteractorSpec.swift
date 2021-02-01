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
      it("login 메서드가 호출 할 경우 listener의 didLoginCallCount는 1이 된다") {
        interactor.login()
        expect(listener.didLoginCallCount) == 1
      }
    }
  }
}
