import IGListKit

// MARK: - ProfileInformationItem

final class ProfileInformationItem {

  // MARK: Lifecycle

  init(sectionID: Int, displayModel: ProfileDisplayModel.InformationDisplayModel) {
    self.sectionID = sectionID
    userName = displayModel.userName
    avatarImageURL = displayModel.avatarImageURL
    postCount = displayModel.postCount
    followerCount = displayModel.followerCount
    followingCount = displayModel.followingCount
    bioDescription = displayModel.bioDescription
  }

  // MARK: Internal

  let userName: String
  let avatarImageURL: String
  let postCount: String
  let followingCount: String
  let followerCount: String
  let bioDescription: String
  let sectionID: Int

}

// MARK: ListDiffable

extension ProfileInformationItem: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    sectionID as NSObjectProtocol
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    if self === object { return true }
    guard let item = object as? ProfileInformationItem else { return false }
    return userName == item.userName
      && avatarImageURL == item.avatarImageURL
      && postCount == item.postCount
      && followerCount == item.followerCount
      && followingCount == item.followingCount
      && bioDescription == item.bioDescription
  }
}
