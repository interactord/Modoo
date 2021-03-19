import Foundation

enum UserInformationSectionModel {
  struct Header: Equatable, DefaultValueUsable {

    // MARK: Lifecycle

    init(userRepositoryModel: UserRepositoryModel, socialRepositoryModel: UserSocialRepositoryModel, isFollowed: Bool = false, postCount: Int = 0) {
      userName = userRepositoryModel.username
      avatarImageURL = userRepositoryModel.profileImageURL
      followingCount = "\(socialRepositoryModel.following)"
      followerCount = "\(socialRepositoryModel.followers)"
      bioDescription = ""
      self.postCount = "\(postCount)"
      self.isFollowed = isFollowed
    }

    init() {
      userName = ""
      avatarImageURL = ""
      postCount = ""
      followingCount = ""
      followerCount = ""
      bioDescription = ""
      isFollowed = false
    }

    // MARK: Internal

    var userName: String
    var avatarImageURL: String
    var postCount: String
    var followingCount: String
    var followerCount: String
    var bioDescription: String
    var isFollowed: Bool

    static func defaultValue() -> Self {
      Self.init()
    }
  }

}
