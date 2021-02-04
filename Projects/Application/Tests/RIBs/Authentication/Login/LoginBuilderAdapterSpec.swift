import Nimble
import Quick
@testable import Application

class LoginBuilderAdapterSpec: QuickSpec {

  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var adapter: LoginBuilderAdapter!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: LoginListenerMock!

    let id = "LoginBuilderAdapterSpecID"
    BuilderContainer.register(builder: LoginBuilderAdapter.self, with: id)

    describe("LoginBuilderAdapter") {
      beforeEach {
        let builderType: LoginBuilderAdapter.Type = BuilderContainer.resolve(for: id)
        adapter = builderType.init(dependency: LoginDependencyMock())
        listener = LoginListenerMock()
        _ = adapter.build(withListener: listener)
      }
      afterEach {
        adapter = nil
        listener = nil
      }

      context("routeToOnboard 실행시") {
        beforeEach {
          adapter.routeToOnboard()
        }

        it("listener routeToOnboardCallCount는 1이다") {
          expect(listener.routeToOnboardCallCount) == 1
        }
      }

      context("routeToRegister 실행시") {
        beforeEach {
          adapter.routeToRegister()
        }

        it("listener routeToRegisterCallCount는 1이다") {
          expect(listener.routeToRegisterCallCount) == 1
        }
      }
    }
  }
}
