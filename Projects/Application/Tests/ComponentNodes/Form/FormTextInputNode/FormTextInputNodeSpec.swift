import AsyncDisplayKit
import Nimble
import Quick
import UIKit

@testable import Application

class FormTextInputNodeSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var node: FormTextInputNode!
    var beforeBackgroundBorderColor: CGColor?

    beforeEach {
      node = FormTextInputNode(scope: .email)
      beforeBackgroundBorderColor = node.backgroundNode.borderColor
    }
    afterEach {
      node = nil
    }

    describe("화면에 렌더링이 되고난 이후") {
      beforeEach {
        node.didLoad()

        let containedSize = ASSizeRange(
          min: .init(width: 300, height: 400),
          max: .init(width: 600, height: 800))

        _ = node.layoutSpecThatFits(containedSize)
      }

      context("FormTextInputNode의 textView의 editingChanged을 전송하면") {
        beforeEach {
          node.textView?.sendActions(for: .editingChanged)
        }

        it("background border color가 변경된다") {
          expect(beforeBackgroundBorderColor).toNotEventually(equal(node.backgroundNode.borderColor), timeout: TestUtil.Const.timeout)
        }
      }

      context("FormTextInputNode의 textView의 editingChanged을 전송하면") {
        beforeEach {
          node.textView?.sendActions(for: [.editingDidEnd, .editingDidEndOnExit])
        }

        it("background border color가 원래대로 돌아온다") {
          expect(beforeBackgroundBorderColor).toEventually(equal(node.backgroundNode.borderColor), timeout: TestUtil.Const.timeout)
        }
      }
    }
  }
}
