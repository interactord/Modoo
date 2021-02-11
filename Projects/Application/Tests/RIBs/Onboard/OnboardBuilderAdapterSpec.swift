import Nimble
import Quick
@testable import Application

class OnboardBuilderAdapterSpec: QuickSpec {

  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var adapter: OnboardBuilderAdapter!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: OnboardListenerMock!

    let id = "OnboardBuilderAdapterSpecID"
    BuilderContainer.register(builder: OnboardBuilderAdapter.self, with: id)

    beforeEach {
      let builderType: OnboardBuilderAdapter.Type = BuilderContainer.resolve(for: id)
      adapter = builderType.init(dependency: OnboardDependencyMock())
      listener = OnboardListenerMock()
    }
    afterEach {
      adapter = nil
      listener = nil
    }

    describe("AuthenticationBuilderAdapter 빌드시") {
      beforeEach {
        _ = adapter.build(withListener: listener)
      }

      context("routeToOnboard 호출 시") {
        beforeEach {
          adapter.routeToAuthentication()
        }

        it("authenticationListener routeToOnboardCallCount는 1이다") {
          expect(listener.routeToAuthenticationCallCount) == 1
        }
      }
    }
  }
}
