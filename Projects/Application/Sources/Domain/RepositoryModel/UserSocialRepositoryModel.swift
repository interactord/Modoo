import Foundation

struct UserSocialRepositoryModel: Decodable {
  let followers: Int
  let following: Int

  init(followers: Int, following: Int) {
    self.followers = followers
    self.following = following
  }

  init() {
    followers = 0
    following = 0
  }
}
