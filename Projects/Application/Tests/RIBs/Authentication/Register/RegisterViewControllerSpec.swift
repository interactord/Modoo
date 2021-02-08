import Nimble
import Quick

@testable import Application

class RegisterViewControllerSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: RegisterViewController!
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: RegisterInteractor!
    // swiftlint:disable implicitly_unwrapped_optional
    var listenerMock: RegisterListenerMock!

    beforeEach {
      viewController = RegisterViewController(mediaPickerUseCase: MediaPickerPlatformUseCase())
      interactor = RegisterInteractor(presenter: viewController, initialState: .init())
      listenerMock = RegisterListenerMock()
      interactor.listener = listenerMock
      viewController.listener = interactor
    }
    afterEach {
      viewController = nil
      interactor = nil
      listenerMock = nil
    }

    describe("RegisterViewController viewLoad 호출시") {
      beforeEach {
        viewController.viewDidLoad()
        viewController.viewDidLayoutSubviews()
      }

      context("가입버튼을 누를 경우") {
        beforeEach {
          viewController.node.signUpButtonNode.sendActions(forControlEvents: .touchUpInside, with: .none)
        }

        it("listenerMock routeToOnboard는 1이다") {
          expect(listenerMock.routeToOnboardCallCount).toEventually(equal(1), timeout: .milliseconds(300))
        }
      }

      context("로그인버튼을 누를 경우") {
        beforeEach {
          viewController.node.alreadyHaveAccountButtonNode.sendActions(forControlEvents: .touchUpInside, with: .none)
        }

        it("listenerMock routeToOnboard는 1이다") {
          expect(listenerMock.routeToLogInCallCount).toEventually(equal(1), timeout: .milliseconds(300))
        }
      }
    }
  }
}
