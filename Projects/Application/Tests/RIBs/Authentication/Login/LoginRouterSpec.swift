import Nimble
import Quick
@testable import Application

class LoginRouterSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var router: LoginRouter!
    // swiftlint:disable implicitly_unwrapped_optional
    var viewController: LoginViewControllableMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var interactor: LoginInteractableMock!

    beforeEach {
      interactor = LoginInteractableMock()
      viewController = LoginViewControllableMock()
      router = LoginRouter(interactor: interactor, viewController: viewController)
    }
    afterEach {
      router = nil
      viewController = nil
      interactor = nil
    }

    describe("LoginRouter didLoad 실행시") {
      beforeEach {
        router.didLoad()
      }
    }
  }
}
