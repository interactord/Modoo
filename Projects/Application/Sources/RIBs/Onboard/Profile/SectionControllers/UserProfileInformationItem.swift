import IGListKit

// MARK: - UserProfileInformationItem

final class UserProfileInformationItem {

  // MARK: Lifecycle

  init(displayModel: UserProfileInformationDisplayModel) {
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

}

// MARK: ListDiffable

extension UserProfileInformationItem: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    userName as NSObjectProtocol
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let item = object as? UserProfileInformationItem else { return false }
    return userName == item.userName
      && avatarImageURL == item.avatarImageURL
      && postCount == item.postCount
      && followerCount == item.followerCount
      && followingCount == item.followingCount
      && bioDescription == item.bioDescription
  }
}
