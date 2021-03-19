import Nimble
import Quick

@testable import Application

class SubFeedAdaptorSpec: QuickSpec {

  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var adapter: SubFeedBuilderAdapter!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: SubFeedListenerMock!

    let id = "SubFeedAdaptorSpecID"
    BuilderContainer.register(builder: SubFeedBuilderAdapter.self, with: id)

    beforeEach {
      let builderType: SubFeedBuilderAdapter.Type = BuilderContainer.resolve(for: id)
      adapter = builderType.init(dependency: SubFeedDependencyMock())
      listener = SubFeedListenerMock()
    }
    afterEach {
      adapter = nil
      listener = nil
    }

    describe("빌드가 되고 나서") {
      beforeEach {
        _ = adapter.build(withListener: listener, model: .defaultValue())
      }

      context("routeToClose 호출 시") {
        beforeEach {
          adapter.routeToClose()
        }

        it("listener routeToClose가 호출된다") {
          expect(listener.routeToCloseCallCount) == 1
        }
      }
    }
  }
}
