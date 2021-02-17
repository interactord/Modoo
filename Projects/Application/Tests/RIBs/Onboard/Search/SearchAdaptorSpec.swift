import Nimble
import Quick
@testable import Application

class SearchAdaptorSpec: QuickSpec {

  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var adapter: SearchBuilderAdapter!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: SearchListenerMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var routing: SearchRouting!

    let id = "SearchAdaptorSpecID"
    BuilderContainer.register(builder: SearchBuilderAdapter.self, with: id)

    beforeEach {
      let builderType: SearchBuilderAdapter.Type = BuilderContainer.resolve(for: id)
      adapter = builderType.init(dependency: SearchDependencyMock())
      listener = SearchListenerMock()
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
