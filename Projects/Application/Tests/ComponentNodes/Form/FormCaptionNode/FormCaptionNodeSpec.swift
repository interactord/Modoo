import AsyncDisplayKit
import BonMot
import Nimble
import Quick
import RxSwift
import UIKit
@testable import Application

class FormCaptionNodeSpec: QuickSpec {

  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var node: FormCaptionNode!
    // swiftlint:disable implicitly_unwrapped_optional
    var reactor: FormCaptionReactor!

    beforeEach {
      node = FormCaptionNode(scope: .init(placeholderText: "test", minCount: 3, maxCount: 10))
      reactor = node.reactor
    }
    afterEach {
      node = nil
      reactor = nil
    }

    describe("화면에 렌더링이 되고난 이후") {
      beforeEach {
        node.didLoad()

        let containedSize = ASSizeRange(
          min: .init(width: 300, height: 400),
          max: .init(width: 600, height: 800))

        _ = node.layoutSpecThatFits(containedSize)
      }

      context("사용자가 123이라고 입력하면") {
        beforeEach {
          node.captionNode.textView.insertText("123")
          reactor.action.onNext(.typingText("123"))
        }

        it("captionNode 텍스트에 123이 들어간다") {
          let result = node.captionNode.attributedText?.string ?? ""
          expect(result).toEventually(equal("123"), timeout: TestUtil.Const.timeout)
        }
      }
    }
  }
}
