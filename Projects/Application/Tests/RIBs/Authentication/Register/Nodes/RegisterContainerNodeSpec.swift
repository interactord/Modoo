import Nimble
import Quick

@testable import Application

class RegisterContainerNodeSpec: QuickSpec {
  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var node: RegisterContainerNode!

    beforeEach {
      node = RegisterContainerNode()
    }
    afterEach {
      node = nil
    }

    describe("RegisterContainerNode") {

      context("레이아웃 호출 테스트") {
        beforeEach {
          _ = node.layoutSpecThatFits(
            .init(
              min: .init(width: 100, height: 100),
              max: .init(width: 200, height: 200)))
        }

        it("에러가 발생하지 않는다") {
          expect(node).toNot(beNil())
        }
      }
    }
  }
}
