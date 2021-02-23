import Nimble
import Quick
@testable import Application

class SubProfileAdaptorSpec: QuickSpec {

  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var adapter: SubProfileBuilderAdapter!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: SubProfileListenerMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var routing: SubProfileRouting!

    let id = "SubProfileAdaptorSpecID"
    BuilderContainer.register(builder: SubProfileBuilderAdapter.self, with: id)

    beforeEach {
      let builderType: SubProfileBuilderAdapter.Type = BuilderContainer.resolve(for: id)
      adapter = builderType.init(dependency: SubProfileDependencyMock())
      listener = SubProfileListenerMock()
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
