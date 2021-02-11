import Nimble
import Quick
@testable import Application

class FeedAdaptorSpec: QuickSpec {

  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var adapter: FeedBuilderAdapter!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: FeedListenerMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var routing: FeedRouting!

    let id = "FeedAdaptorSpecID"
    BuilderContainer.register(builder: FeedBuilderAdapter.self, with: id)

    beforeEach {
      let builderType: FeedBuilderAdapter.Type = BuilderContainer.resolve(for: id)
      adapter = builderType.init(dependency: FeedDependencyMock())
      listener = FeedListenerMock()
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
