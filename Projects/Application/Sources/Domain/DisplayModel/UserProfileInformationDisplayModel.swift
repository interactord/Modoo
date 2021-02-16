import Foundation

enum ProfileDisplayModel {

  enum MediaContentType {
    case grid
    case list
    case bookmark
  }

  struct MediaContentDisplayModel {
    let type: MediaContentType
    let dummy: String
  }

  struct InformationDisplayModel {
    let userName: String
    let avatarImageURL: String
    let postCount: String
    let followingCount: String
    let followerCount: String
    let bioDescription: String
  }

}
