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

    describe("FormTextInputNode의 textView의 editingChanged을 전송하면") {
      beforeEach {
        node.textView?.sendActions(for: .editingChanged)
      }

      it("background border color가 변경된다") {
        expect(beforeBackgroundBorderColor).toNotEventually(equal(node.backgroundNode.borderColor), timeout: TestUtil.Const.timeout)
      }
    }

    describe("FormTextInputNode의 textView의 editingChanged을 전송하면") {
      beforeEach {
        node.textView?.sendActions(for: [.editingDidEnd, .editingDidEndOnExit])
      }

      it("background border color가 원래대로 돌아온다") {
        expect(beforeBackgroundBorderColor).toEventually(equal(node.backgroundNode.borderColor), timeout: TestUtil.Const.timeout)
      }
    }
  }
}
