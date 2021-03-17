import Nimble
import Quick
import UIKit
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
      routing = adapter.build(withListener: listener, image: UIImage())
    }
    afterEach {
      adapter = nil
      listener = nil
      routing = nil
    }

    describe("빌드가 완료된 이후") {

      it("routing은 nil이 아니다") {
        expect(routing).toNot(beNil())
      }

      context("routeToClose 메서드를 호출하면") {
        beforeEach {
          adapter.routeToClose()
        }

        it("listener routeToClose 메서드가 호출이 된다 ") {
          expect(listener.routeToCloseCallCount) == 1
        }
      }
    }
  }
}
