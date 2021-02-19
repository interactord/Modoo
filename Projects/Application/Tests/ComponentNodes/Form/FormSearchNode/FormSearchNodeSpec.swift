import AsyncDisplayKit
import Nimble
import Quick
import RxSwift
import UIKit

@testable import Application

class FormSearchNodeSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var node: FormSearchNode!

    beforeEach {
      node = FormSearchNode()
    }
    afterEach {
      node = nil
    }

    describe("화면에 렌더링이 되고난 이후") {
      beforeEach {
        node.didLoad()
        node.searchFieldNode.didLoad()

        let containedSize = ASSizeRange(
          min: .init(width: 300, height: 400),
          max: .init(width: 600, height: 800))

        _ = node.layoutSpecThatFits(containedSize)
      }

      it("cancelButton는 가려져 있다") {
        node.cancelButtonNode.isHidden = true
      }

      context("현재 검색 필드에 test가 입력되었을 경우") {
        beforeEach {
          node.searchFieldNode.textView?.sendActions(for: .editingDidBegin)
          node.searchFieldNode.textView?.rx.text.onNext("test")
        }

        it("검색 필드에 텍스트는 test가 된다") {
          expect(node.searchFieldNode.textView?.text) == "test"
        }

        it("cancelButton이 노출이 된다") {
          expect(node.cancelButtonNode.isHidden).toEventually(equal(false), timeout: TestUtil.Const.timeout)
        }

        context("취소 버튼을 누를 경우") {
          beforeEach {
            node.cancelButtonNode.sendActions(forControlEvents: .touchUpInside, with: .none)
          }

          it("검색 필드에 텍스트는 빈값이다") {
            expect(node.searchFieldNode.textView?.text) == ""
          }

          it("cancelButton이 미 노출이 된다") {
            expect(node.cancelButtonNode.isHidden).toEventually(equal(true), timeout: TestUtil.Const.timeout)
          }
        }
      }
    }
  }
}
