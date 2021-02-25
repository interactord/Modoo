import Nimble
import Quick
@testable import Application

class PostAdaptorSpec: QuickSpec {

  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var adapter: PostBuilderAdapter!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: PostListenerMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var routing: PostRouting!

    let id = "PostAdaptorSpecID"
    BuilderContainer.register(builder: PostBuilderAdapter.self, with: id)

    beforeEach {
      let builderType: PostBuilderAdapter.Type = BuilderContainer.resolve(for: id)
      adapter = builderType.init(dependency: PostDependencyMock())
      listener = PostListenerMock()
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
