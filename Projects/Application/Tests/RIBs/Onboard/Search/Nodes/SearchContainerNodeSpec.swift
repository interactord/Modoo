import AsyncDisplayKit
import Nimble
import Quick
@testable import Application

class SearchContainerNodeSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var node: SearchContainerNode!

    beforeEach {
      node = SearchContainerNode()
    }
    afterEach {
      node = nil
    }

    describe("화면에 렌더링이 되고난 이후") {
      beforeEach {

        let containedSize = ASSizeRange(
          min: .init(width: 300, height: 400),
          max: .init(width: 600, height: 800))

        _ = node.layoutSpecThatFits(containedSize)
      }

      it("크래시가 발생하지 않는다") {
        expect(node).toNot(beNil())
      }
    }

  }
}
