import Nimble
import Quick
@testable import Application

class AuthenticationAdaptorSpec: QuickSpec {

  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var adapter: AuthenticationBuilderAdapter!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: AuthenticationListenerMock!

    let id = "AuthenticationAdaptorSpecID"
    BuilderContainer.register(builder: AuthenticationBuilderAdapter.self, with: id)

    describe("AuthenticationBuilderAdapter") {
      beforeEach {
        let builderType: AuthenticationBuilderAdapter.Type = BuilderContainer.resolve(for: id)
        adapter = builderType.init(dependency: AuthenticationDependencyMock())
        listener = AuthenticationListenerMock()
        _ = adapter.build(withListener: listener)
      }

      context("routeToLoggedIn 호출 시") {
        beforeEach {
          adapter.routeToLoggedIn()
        }

        it("authenticationListener routeToLoginCallCount는 1이다") {
          expect(listener.routeToLoggedInCallCount) == 1
        }
      }
    }
  }
}
