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
      routing = adapter.build(withListener: listener, uid: "test")
    }
    afterEach {
      adapter = nil
      listener = nil
      routing = nil
    }

    describe("리스너 테스트") {
      context("routeToBack 메서드가 불리면") {
        beforeEach {
          adapter.routeToBack()
        }

        it("listener routeToBack을 호출한다") {
          expect(listener.routeToBackCallCount) == 1
        }
      }
    }
  }
}
