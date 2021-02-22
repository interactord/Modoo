import IGListKit
@testable import Application

// MARK: - SingleHeaderItemMock

final class SingleHeaderItemMock: CollectionDisplayModeling {

  // MARK: Lifecycle

  init(sectionID: String, headerItem: String, cellItems: [String], footerItem: String) {
    self.sectionID = sectionID
    self.headerItem = headerItem
    self.cellItems = cellItems
    self.footerItem = footerItem
  }

  convenience init() {
    self.init(
      sectionID: UUID().uuidString,
      headerItem: "headerItem",
      cellItems: [],
      footerItem: "footerItem")
  }

  // MARK: Internal

  var sectionID: String
  var headerItem: String
  var cellItems: [String]
  var footerItem: String

}

// MARK: ListDiffable

extension SingleHeaderItemMock: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    sectionID as NSObjectProtocol
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let item = object as? SingleHeaderItemMock else { return false }
    return headerItem == item.headerItem
      && cellItems == item.cellItems
      &&  footerItem == item.footerItem
  }
}
