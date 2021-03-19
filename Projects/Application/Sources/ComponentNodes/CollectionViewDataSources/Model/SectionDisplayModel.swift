import Foundation
import IGListKit

final class SectionDisplayModel<HeaderItem: Equatable & DefaultValueUsable, CellItem: Equatable & DefaultValueUsable, FooterItem: Equatable & DefaultValueUsable>: SectionDisplayModeling, ListDiffable, Equatable, DefaultValueUsable {

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

  static func defaultValue() -> Self {
    Self.init(sectionID: UUID().uuidString, headerItem: .defaultValue(), cellItems: [], footerItem: .defaultValue())
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
