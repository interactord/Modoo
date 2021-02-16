import IGListKit

// MARK: - ProfileContentItem

final class ProfileContentItem {

  // MARK: Lifecycle

  init(displayModel: ProfileDisplayModel.MediaContentDisplayModel) {
    type = displayModel.type
    dummy = displayModel.dummy
  }

  // MARK: Internal

  let type: ProfileDisplayModel.MediaContentType
  let dummy: String

}

// MARK: ListDiffable

extension ProfileContentItem: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    dummy as NSObjectProtocol
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let item = object as? ProfileContentItem else { return false }
    return type == item.type
  }
}
