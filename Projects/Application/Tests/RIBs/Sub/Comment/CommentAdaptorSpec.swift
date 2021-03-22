import Nimble
import Quick

@testable import Application

class CommentAdaptorSpec: QuickSpec {

  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var adapter: CommentBuilderAdapter!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: CommentListenerMock!
    // swiftlint:disable implicitly_unwrapped_optional
    var routing: CommentRouting!

    let id = "CommentAdaptorSpecID"
    BuilderContainer.register(builder: CommentBuilderAdapter.self, with: id)

    beforeEach {
      let builderType: CommentBuilderAdapter.Type = BuilderContainer.resolve(for: id)
      adapter = builderType.init(dependency: CommentDependencyMock())
      listener = CommentListenerMock()
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
