import AsyncDisplayKit
import Nimble
import Quick
import UIKit
@testable import Application

class SectionControllerSpec: QuickSpec {

  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var controller: SectionController<SingleHeaderItemMock>!

    beforeEach {
      controller = SectionController<SingleHeaderItemMock>(
        elementKindTypes: [.header, .footer],
        supplementaryViewBlock: { _ in EmptyCellMock() },
        numberOfCellItemsBlock: { _ in 10 },
        sizeForItemWidthBlock: { 100 },
        nodeForItemBlock: { _ in EmptyCellMock() })
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

        context("아이템 셀의 갯수를 가져오는 경우") {
          context("numberOfCellItemsBlock에서 10개값을 주입하면") {
            beforeEach {
              controller.numberOfCellItemsBlock = { _ in 10 }
            }

            it("아이템의 갯수는 10이다"){
              expect(controller.numberOfItems()) == 10
            }
          }

          context("numberOfCellItemsBlock이 nil이면") {
            beforeEach {
              controller.numberOfCellItemsBlock = nil
            }

            it("아이템의 갯수는 0이다"){
              expect(controller.numberOfItems()) == 0
            }
          }
        }

        context("아이템 셀을 가져올 경우") {
          context("nodeForItemBlock이 nil이면") {
            beforeEach {
              controller.nodeForItemBlock = nil
            }
            it("가져온 셀은 EmptyCellMock 아니다") {
              let cell = controller.nodeBlockForItem(at: 0)()
              expect(cell is EmptyCellMock).toNot(beTrue())
            }
          }

          context("nodeForItemBlock이 nil이 아니면") {
            it("가져온 셀은 EmptyCellMock 이다") {
              let cell = controller.nodeBlockForItem(at: 0)()
              expect(cell is EmptyCellMock).to(beTrue())
            }
          }

          context("최대사이즈를 가져오는 경우") {
            context("sizeForItemWidthBlock에 100.0을 추가했을 경우") {
              beforeEach {
                controller.sizeForItemWidthBlock = { 100 }
              }

              it("사이즈의 넓이의 최대 값은 100이 된다") {
                expect(controller.sizeRangeForItem(at: 0).max.width) == 100
              }
            }

            context("sizeForItemWidthBlock가 nil인 경우") {
              beforeEach {
                controller.sizeForItemWidthBlock = nil
              }

              it("사이즈의 넓이의 최대 값은 무한이 된다") {
                expect(controller.sizeRangeForItem(at: 0).max.width) == CGFloat.infinity
              }
            }
          }
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

        context("supplementaryViewBlock이 nil 인경우") {
          beforeEach {
            controller.supplementaryViewBlock = nil
          }
          it("가져온 셀은 EmptyCellMock이 아니다") {
            let cell = controller.nodeBlockForSupplementaryElement(ofKind: UICollectionView.elementKindSectionHeader, at: 0)()
            expect(cell is EmptyCellMock).toNot(beTrue())
          }
        }

      }

      context("다른 타입으로 주입이 될 겨우") {
        beforeEach {
          controller.didUpdate(to: "test")
        }

        context("아이템 셀의 갯수를 가져오는 경우") {
          context("numberOfCellItemsBlock에서 10개값을 주입하면") {
            beforeEach {
              controller.numberOfCellItemsBlock = { _ in 10 }
            }

            it("아이템의 갯수는 0이다"){
              expect(controller.numberOfItems()) == 0
            }
          }

          context("numberOfCellItemsBlock이 nil이면") {
            beforeEach {
              controller.numberOfCellItemsBlock = nil
            }

            it("아이템의 갯수는 0이다"){
              expect(controller.numberOfItems()) == 0
            }
          }
        }

        it("controller의 아이템은 nil이다") {
          expect(controller.item).to(beNil())
        }

        context("아이템 셀을 가져올 경우") {
          context("nodeForItemBlock이 nil이면") {
            beforeEach {
              controller.nodeForItemBlock = nil
            }
            it("가져온 셀은 EmptyCellMock 아니다") {
              let cell = controller.nodeBlockForItem(at: 0)()
              expect(cell is EmptyCellMock).toNot(beTrue())
            }
          }

          context("nodeForItemBlock이 nil이 아니면") {
            it("가져온 셀은 EmptyCellMock 아니다") {
              let cell = controller.nodeBlockForItem(at: 0)()
              expect(cell is EmptyCellMock).toNot(beTrue())
            }
          }
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

        context("supplementaryViewBlock이 nil 인경우") {
          beforeEach {
            controller.supplementaryViewBlock = nil
          }
          it("가져온 셀은 EmptyCellMock이 아니다") {
            let cell = controller.nodeBlockForSupplementaryElement(ofKind: UICollectionView.elementKindSectionHeader, at: 0)()
            expect(cell is EmptyCellMock).toNot(beTrue())
          }
        }
      }

    }
  }
}
