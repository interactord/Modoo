import IGListKit

// MARK: - SearchUserContentSectionItemModel

final class SearchUserContentSectionItemModel: SectionDisplayModeling {

  // MARK: Lifecycle

  init(sectionID: String, sectionItem: SearchDisplayModel.SearchContentSectionItem) {
    self.sectionID = sectionID
    self.sectionItem = sectionItem
  }

  convenience init() {
    self.init(sectionID: UUID().uuidString, sectionItem: .init(items: []))
  }

  // MARK: Internal

  let sectionID: String
  let sectionItem: SearchDisplayModel.SearchContentSectionItem
  var footerItem: String = ""
  var headerItem: String = ""

  var cellItems: [SearchDisplayModel.SearchContentSectionItem.Item] {
    sectionItem.items
  }

}

// MARK: ListDiffable

extension SearchUserContentSectionItemModel: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    sectionID as NSObjectProtocol
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    if self === object { return true }
    guard let item = object as? SearchUserContentSectionItemModel else { return false }
    return sectionItem == item.sectionItem
  }
}
