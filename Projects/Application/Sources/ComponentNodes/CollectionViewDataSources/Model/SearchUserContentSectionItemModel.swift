import IGListKit

// MARK: - SearchUserContentSectionItemModel

final class SearchUserContentSectionItemModel {

  // MARK: Lifecycle

  init(sectionID: Int, sectionItem: SearchDisplayModel.SearchContentSectionItem) {
    self.sectionID = sectionID
    self.sectionItem = sectionItem
  }

  convenience init() {
    self.init(sectionID: UUID().hashValue, sectionItem: .init(items: []))
  }

  // MARK: Internal

  let sectionID: Int
  let sectionItem: SearchDisplayModel.SearchContentSectionItem
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
