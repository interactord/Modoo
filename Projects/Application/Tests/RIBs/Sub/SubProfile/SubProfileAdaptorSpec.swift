import Nimble
import Quick
@testable import Application

class SubProfileAdaptorSpec: QuickSpec {

  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var adapter: SubProfileBuilderAdapter!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: SubProfileListenerMock!

    let id = "SubProfileAdaptorSpecID"
    BuilderContainer.register(builder: SubProfileBuilderAdapter.self, with: id)

    beforeEach {
      let builderType: SubProfileBuilderAdapter.Type = BuilderContainer.resolve(for: id)
      adapter = builderType.init(dependency: SubProfileDependencyMock())
      listener = SubProfileListenerMock()
    }
    afterEach {
      adapter = nil
      listener = nil
    }

    describe("빌드가 되고나서") {
      beforeEach {
        _ = adapter.build(withListener: listener, uid: "test")
      }

      context("routeToSubFeed 메서드가 불리면") {
        beforeEach {
          adapter.routeToSubFeed(model: .defaultValue())
        }

        it("listener routeToSubFeed을 호출한다") {
          expect(listener.routeToSubFeedCallCount) == 1
        }
      }

      context("routeToBack 메서드가 불리면") {
        beforeEach {
          adapter.routeToBackFromSubProfile()
        }

        it("listener routeToBack을 호출한다") {
          expect(listener.routeToBackCallCount) == 1
        }
      }
    }
  }
}
