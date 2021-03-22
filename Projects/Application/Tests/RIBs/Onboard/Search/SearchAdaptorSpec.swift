import Nimble
import Quick
@testable import Application

class SearchAdaptorSpec: QuickSpec {

  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var adapter: SearchBuilderAdapter!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: SearchListenerMock!

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
        _ = adapter.build(withListener: listener)
      }

      context("routeToSubFeed 호출 시") {
        beforeEach {
          adapter.routeToSubFeed(model: .defaultValue())
        }

        it("listener routeToSubFeed가 불린다") {
          expect(listener.routeToSubFeedCallCount) == 1
        }
      }
    }
  }
}
