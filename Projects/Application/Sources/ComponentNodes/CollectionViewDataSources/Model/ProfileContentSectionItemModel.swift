import IGListKit

// MARK: - ProfileContentSectionItemModel

final class ProfileContentSectionItemModel {

  // MARK: Lifecycle

  init(sectionID: Int, sectionItem: ProfileDisplayModel.MediaContentDisplayModel) {
    self.sectionID = sectionID
    type = sectionItem.type
    dummy = sectionItem.dummy
  }

  convenience init() {
    self.init(sectionID: UUID().hashValue, sectionItem: .init())
  }

  // MARK: Internal

  let type: ProfileDisplayModel.MediaContentType
  let dummy: String
  let sectionID: Int

}

// MARK: ListDiffable

extension ProfileContentSectionItemModel: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    sectionID as NSObjectProtocol
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    if self === object { return true }
    guard let item = object as? ProfileContentSectionItemModel else { return false }
    return type == item.type
  }
}
