import IGListKit

// MARK: - ProfileInformationSectionItemModel

final class ProfileInformationSectionItemModel: CollectionDisplayModeling {

  // MARK: Lifecycle

  init(sectionID: String, sectionItem: ProfileDisplayModel.InformationSectionItem) {
    self.sectionID = sectionID
    self.sectionItem = sectionItem
  }

  convenience init() {
    self.init(sectionID: UUID().uuidString, sectionItem: .init())
  }

  // MARK: Internal

  var sectionID: String
  var cellItems: [String] = []
  var footerItem: String = ""
  var sectionItem: ProfileDisplayModel.InformationSectionItem

  var headerItem: ProfileDisplayModel.InformationSectionItem.HeaderItem {
    sectionItem.headerItem
  }

}

// MARK: ListDiffable

extension ProfileInformationSectionItemModel: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    sectionID as NSObjectProtocol
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    if self === object { return true }
    guard let item = object as? ProfileInformationSectionItemModel else { return false }
    return sectionItem == item.sectionItem
  }
}
