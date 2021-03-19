import Nimble
import Quick
import RIBs
@testable import Application

class SectionDisplayModelSpec: QuickSpec {

  override func spec() {
    // swiftlint:disable implicitly_unwrapped_optional
    var sectionDisplayModelA: SectionDisplayModel<SectionItemMock, SectionItemMock, SectionItemMock>!
    // swiftlint:disable implicitly_unwrapped_optional
    var sectionDisplayModelAA: SectionDisplayModel<SectionItemMock, SectionItemMock, SectionItemMock>!
    // swiftlint:disable implicitly_unwrapped_optional
    var sectionDisplayModelB: SectionDisplayModel<SectionItemMock, SectionItemMock, SectionItemMock>!

    beforeEach {
      let uuid = UUID().uuidString
      sectionDisplayModelA = .init(
        sectionID: uuid,
        headerItem: .init(title: "header model A"),
        cellItems: [.init(title: "cell model A")],
        footerItem: .init(title: "footer model A"))
      sectionDisplayModelAA = .init(
        sectionID: uuid,
        headerItem: .init(title: "header model AA"),
        cellItems: [.init(title: "cell model AA")],
        footerItem: .init(title: "footer model AA"))
      sectionDisplayModelB = .init(
        sectionID: UUID().uuidString,
        headerItem: .init(title: "header model A"),
        cellItems: [.init(title: "cell model A")],
        footerItem: .init(title: "footer model A"))
    }
    afterEach {
      sectionDisplayModelA = nil
      sectionDisplayModelAA = nil
      sectionDisplayModelB = nil
    }

    describe("SectionDisplayModel 기능 테스트") {
      context("diffIdentifier 테스트") {
        it("sectionDisplayModelA와 sectionDisplayModelAA는 유니크 키가 동일하다") {
          expect("\(sectionDisplayModelA.diffIdentifier())") == "\(sectionDisplayModelAA.diffIdentifier())"
        }

        it("sectionDisplayModelA와 sectionDisplayModelB는 유니크 키가 동일하지 않다") {
          expect("\(sectionDisplayModelA.diffIdentifier())") != "\(sectionDisplayModelB.diffIdentifier())"
        }
      }

      context("isEqual 테스트") {
        it("sectionDisplayModelA와 sectionDisplayModelAA 동일하지 않느다") {
          expect(sectionDisplayModelA.isEqual(toDiffableObject: sectionDisplayModelAA)) != true
        }

        it("sectionDisplayModelA와 sectionDisplayModelB 동일하지 않는다") {
          expect(sectionDisplayModelA.isEqual(toDiffableObject: sectionDisplayModelB)) != true
        }
      }
    }
  }
}
