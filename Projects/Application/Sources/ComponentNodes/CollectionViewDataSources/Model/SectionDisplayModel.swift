import Foundation
import IGListKit

final class SectionDisplayModel<HeaderItem: Equatable & Defaultable, CellItem: Equatable & Defaultable, FooterItem: Equatable & Defaultable>: SectionDisplayModeling, ListDiffable, Equatable, Defaultable {

  // MARK: Lifecycle

  init(sectionID: String, headerItem: HeaderItem, cellItems: [CellItem], footerItem: FooterItem) {
    self.sectionID = sectionID
    self.headerItem = headerItem
    self.cellItems = cellItems
    self.footerItem = footerItem
  }

  init(headerItem: HeaderItem, original: SectionDisplayModel) {
    self.headerItem = headerItem
    sectionID = original.sectionID
    cellItems = original.cellItems
    footerItem = original.footerItem
  }

  init(cellItems: [CellItem], original: SectionDisplayModel) {
    sectionID = original.sectionID
    headerItem = original.headerItem
    footerItem = original.footerItem
    self.cellItems = cellItems
  }

  // MARK: Internal

  var sectionID: String
  var headerItem: HeaderItem
  var cellItems: [CellItem]
  var footerItem: FooterItem

  static func == (lhs: SectionDisplayModel, rhs: SectionDisplayModel) -> Bool {
    lhs.isEqual(toDiffableObject: rhs)
  }

  static func `default`() -> Self {
    Self.init(sectionID: UUID().uuidString, headerItem: .default(), cellItems: [], footerItem: .default())
  }

  func diffIdentifier() -> NSObjectProtocol {
    sectionID as NSObjectProtocol
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let item = object as? SectionDisplayModel else { return false }
    return sectionID == item.sectionID
      && cellItems == item.cellItems
      && headerItem == item.headerItem
      && footerItem == item.footerItem
  }

}
