import IGListKit

// MARK: - ProfileContentSectionItemModel

final class ProfileContentSectionItemModel: CollectionDisplayModeling {

  // MARK: Lifecycle

  init(sectionID: String, sectionItem: ProfileDisplayModel.MediaContentSectionItem) {
    self.sectionID = sectionID
    self.sectionItem = sectionItem
  }

  convenience init() {
    self.init(sectionID: UUID().uuidString, sectionItem: .init())
  }

  // MARK: Internal

  var sectionID: String
  var footerItem: String = ""
  var sectionItem: ProfileDisplayModel.MediaContentSectionItem

  var cellItems: [ProfileDisplayModel.MediaContentSectionItem.CellItem] {
    sectionItem.cellItems
  }
  var headerItem: ProfileDisplayModel.MediaContentSectionItem.HeaderItem {
    sectionItem.headerItem
  }
}

// MARK: ListDiffable

extension ProfileContentSectionItemModel: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    sectionID as NSObjectProtocol
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    if self === object { return true }
    guard let item = object as? ProfileContentSectionItemModel else { return false }
    return sectionItem == item.sectionItem
  }
}
