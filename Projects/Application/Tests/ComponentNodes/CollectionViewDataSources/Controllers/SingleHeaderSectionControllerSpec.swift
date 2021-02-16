import AsyncDisplayKit
import Nimble
import Quick
import UIKit
@testable import Application

class SingleHeaderSectionControllerSpec: QuickSpec {

  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var controller: SingleHeaderSectionController<SingleHeaderItemMock>!

    beforeEach {
      controller = SingleHeaderSectionController<SingleHeaderItemMock>(elementKindTypes: [.header, .footer], supplementaryViewBlock: { _ in
        EmptyCellMock()
      })
    }
    afterEach {
      controller = nil
    }

    describe("매서드 테스트") {
      context("헤더타입으로 사이즈 조회 시") {
        it("최대값의 사이즈는 0이 아니다") {
          expect(controller.sizeRangeForSupplementaryElement(ofKind: UICollectionView.elementKindSectionHeader, at: 0).max) != .zero
        }
      }

      context("푸터타입으로 사이즈 조회 시") {
        it("최대값의 사이즈는 0이 아니다") {
          expect(controller.sizeRangeForSupplementaryElement(ofKind: UICollectionView.elementKindSectionFooter, at: 0).max) != .zero
        }
      }

      context("잘못된 타입 사이즈 조회 시") {
        it("최대값의 사이즈는 0이다") {
          expect(controller.sizeRangeForSupplementaryElement(ofKind: "test", at: 0).max) == .zero
        }
      }
    }

    describe("아이템이 업데이트 시") {

      context("동일한 타입으로 주입이 될 경우") {
        beforeEach {
          controller.didUpdate(to: SingleHeaderItemMock(id: "1", title: "title-1"))
        }

        it("controller의 아이템은 nil이 아니다") {
          expect(controller.item).toNot(beNil())
        }

        context("헤더 타입으로 셀을 가져올 경우") {
          it("가져온 셀은 EmptyCellMock 이다") {
            let cell = controller.nodeBlockForSupplementaryElement(ofKind: UICollectionView.elementKindSectionHeader, at: 0)()
            expect(cell is EmptyCellMock).to(beTrue())
          }
        }

        context("푸터 타입으로 셀을 가져올 경우") {
          it("가져온 셀은 EmptyCellMock 이다") {
            let cell = controller.nodeBlockForSupplementaryElement(ofKind: UICollectionView.elementKindSectionHeader, at: 0)()
            expect(cell is EmptyCellMock).to(beTrue())
          }
        }

        context("잘못된 타입으로 셀을 가져올 경우") {
          it("가져온 셀은 EmptyCellMock 이다") {
            let cell = controller.nodeBlockForSupplementaryElement(ofKind: UICollectionView.elementKindSectionHeader, at: 0)()
            expect(cell is EmptyCellMock).to(beTrue())
          }
        }

      }

      context("다른 타입으로 주입이 될 겨우") {
        beforeEach {
          controller.didUpdate(to: "test")
        }

        it("controller의 아이템은 nil이다") {
          expect(controller.item).to(beNil())
        }

        context("헤더 타입으로 셀을 가져올 경우") {
          it("가져온 셀은 EmptyCellMock 아니다") {
            let cell = controller.nodeBlockForSupplementaryElement(ofKind: UICollectionView.elementKindSectionHeader, at: 0)()
            expect(cell is EmptyCellMock).toNot(beTrue())
          }
        }

        context("푸터 타입으로 셀을 가져올 경우") {
          it("가져온 셀은 EmptyCellMock 아니다") {
            let cell = controller.nodeBlockForSupplementaryElement(ofKind: UICollectionView.elementKindSectionHeader, at: 0)()
            expect(cell is EmptyCellMock).toNot(beTrue())
          }
        }

        context("잘못된 타입으로 셀을 가져올 경우") {
          it("가져온 셀은 EmptyCellMock 아니다") {
            let cell = controller.nodeBlockForSupplementaryElement(ofKind: UICollectionView.elementKindSectionHeader, at: 0)()
            expect(cell is EmptyCellMock).toNot(beTrue())
          }
        }
      }

    }
  }
}
