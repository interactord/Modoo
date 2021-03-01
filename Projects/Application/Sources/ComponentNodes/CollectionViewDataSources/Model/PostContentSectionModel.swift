import IGListKit

// MARK: - PostContentSectionModel

final class PostContentSectionModel: CollectionDisplayModeling {

  // MARK: Lifecycle

  init(sectionID: String, sectionItem: FeedDisplayModel.PostContentSectionItem) {
    self.sectionID = sectionID
    self.sectionItem = sectionItem
  }

  convenience init() {
    self.init(sectionID: UUID().uuidString, sectionItem: .init(postRepositoryModels: []))
  }

  // MARK: Internal

  var sectionID: String
  let sectionItem: FeedDisplayModel.PostContentSectionItem
  var headerItem: String = ""
  var footerItem: String = ""

  var cellItems: [FeedDisplayModel.PostContentSectionItem.Item] {
    sectionItem.items
  }
}

// MARK: ListDiffable

extension PostContentSectionModel: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    sectionID as NSObjectProtocol
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    if self === object { return true }
    guard let item = object as? PostContentSectionModel else { return false }
    return sectionItem == item.sectionItem
  }
}
