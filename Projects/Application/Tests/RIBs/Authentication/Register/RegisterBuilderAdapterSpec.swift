import Nimble
import Quick
@testable import Application

class RegisterBuilderAdapterSpec: QuickSpec {

  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var adapter: RegisterBuilderAdapter!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: RegisterListenerMock!

    let id = "LoginBuilderAdapterSpecID"
    BuilderContainer.register(builder: LoginBuilderAdapter.self, with: id)

    describe("RegisterBuilderAdapter") {
      beforeEach {
        let builderType: RegisterBuilderAdapter.Type = BuilderContainer.resolve(for: RegisterBuilderID)
        adapter = builderType.init(dependency: RegisterDependencyMock())
        listener = RegisterListenerMock()
        _ = adapter.build(withListener: listener)
      }

      context("routeToLogin 실행시") {
        beforeEach {
          adapter.routeToLogin()
        }

        it("listener routeToLogInCallCount는 1이다") {
          expect(listener.routeToLogInCallCount) == 1
        }
      }
    }

    context("routeToLoggedIn 실행시") {
      beforeEach {
        adapter.routeToLoggedIn()
      }

      it("listener routeToLoggedInCallCount는 1이다") {
        expect(listener.routeToLoggedInCallCount) == 1
      }
    }
  }
}
