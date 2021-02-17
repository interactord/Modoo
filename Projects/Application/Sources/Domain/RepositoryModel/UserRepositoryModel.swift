import Foundation

struct UserRepositoryModel: Decodable {
  let uid: String
  let email: String
  let fullname: String
  let profileImageURL: String
  let username: String
}
