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

    beforeEach {
      let builderType: AuthenticationBuilderAdapter.Type = BuilderContainer.resolve(for: id)
      adapter = builderType.init(dependency: AuthenticationDependencyMock())
      listener = AuthenticationListenerMock()
      _ = adapter.dependency.mediaPickerUseCase
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
          adapter.routeToOnboard()
        }

        it("authenticationListener routeToOnboardCallCount는 1이다") {
          expect(listener.routeToOnboardCallCount) == 1
        }
      }
    }
  }
}
