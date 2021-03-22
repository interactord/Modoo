import Nimble
import Quick

@testable import Application

class CommentAdaptorSpec: QuickSpec {

  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var adapter: CommentBuilderAdapter!
    // swiftlint:disable implicitly_unwrapped_optional
    var listener: CommentListenerMock!

    let id = "CommentAdaptorSpecID"
    BuilderContainer.register(builder: CommentBuilderAdapter.self, with: id)

    beforeEach {
      let builderType: CommentBuilderAdapter.Type = BuilderContainer.resolve(for: id)
      adapter = builderType.init(dependency: CommentDependencyMock())
      listener = CommentListenerMock()
    }
    afterEach {
      adapter = nil
      listener = nil
    }

    describe("빌드가 되고나서") {
      beforeEach {
        _ = adapter.build(withListener: listener)
      }

      context("routeToBackFromComment 호출 시") {
        beforeEach {
          adapter.routeToBackFromComment()
        }

        it("listener routeToBackFromComment가 불린다") {
          expect(listener.routeToBackFromCommentCallCount) == 1
        }
      }
    }
  }
}
