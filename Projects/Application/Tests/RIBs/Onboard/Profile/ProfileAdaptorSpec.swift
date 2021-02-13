import Nimble
import Quick
@testable import Application

class ProfileAdaptorSpec: QuickSpec {

  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var adapter: ProfileBuilderAdapter!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: ProfileListenerMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var routing: ProfileRouting!

    let id = "ProfileAdaptorSpecID"
    BuilderContainer.register(builder: ProfileBuilderAdapter.self, with: id)

    beforeEach {
      let builderType: ProfileBuilderAdapter.Type = BuilderContainer.resolve(for: id)
      adapter = builderType.init(dependency: ProfileDependencyMock())
      listener = ProfileListenerMock()
      routing = adapter.build(withListener: listener)
    }
    afterEach {
      adapter = nil
      listener = nil
      routing = nil
    }

    describe("빌드 완료") {
      it("test") {
        expect(routing).toNot(beNil())
      }
    }
  }
}
