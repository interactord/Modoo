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

      it("크래시 테스트") {
        expect(1) == 1
      }
    }
  }
}
