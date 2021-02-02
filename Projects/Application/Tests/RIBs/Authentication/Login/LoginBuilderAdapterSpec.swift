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

      context("didLogin 호출시") {
        beforeEach {
          adapter.didLogin()
        }

        it("listener didLoginCallCount는 1이다") {
          expect(listener.didLoginCallCount) == 1
        }
      }

      context("didRegister 호출시") {
        beforeEach {
          adapter.didRegister()
        }

        it("listener didRegisterCallCount는 1이다") {
          expect(listener.didRegisterCallCount) == 1
        }
      }
    }
  }
}
