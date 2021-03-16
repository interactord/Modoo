import Nimble
import Quick

@testable import Application

class SubFeedAdaptorSpec: QuickSpec {

  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var adapter: SubFeedBuilderAdapter!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: SubFeedListenerMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var routing: SubFeedRouting!

    let id = "SubFeedAdaptorSpecID"
    BuilderContainer.register(builder: SubFeedBuilderAdapter.self, with: id)

    beforeEach {
      let builderType: SubFeedBuilderAdapter.Type = BuilderContainer.resolve(for: id)
      adapter = builderType.init(dependency: SubFeedDependencyMock())
      listener = SubFeedListenerMock()
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
