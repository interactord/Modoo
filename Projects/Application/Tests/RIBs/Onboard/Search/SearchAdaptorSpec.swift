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
    var searchRouting: SearchRouting!

    let id = "SearchAdaptorSpecID"
    BuilderContainer.register(builder: SearchBuilderAdapter.self, with: id)

    beforeEach {
      let builderType: SearchBuilderAdapter.Type = BuilderContainer.resolve(for: id)
      adapter = builderType.init(dependency: SearchDependencyMock())
      listener = SearchListenerMock()
    }
    afterEach {
      adapter = nil
      listener = nil
    }

    describe("빌드가 되고나서") {
      beforeEach {
        searchRouting = adapter.build(withListener: listener)
      }

      it("크래시 테스트") {
        expect(searchRouting).toNot(beNil())
      }
    }
  }
}
