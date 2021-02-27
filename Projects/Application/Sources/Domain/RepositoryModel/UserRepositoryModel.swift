import Foundation

struct UserRepositoryModel: Decodable, DictionaryModelType {
  let uid: String
  let email: String
  let fullname: String
  let profileImageURL: String
  let username: String

  init(domain: RegisterDisplayModel.State, uid: String, profileImageURL: String) {
    self.uid = uid
    email = domain.formState.email
    fullname = domain.formState.fullName
    self.profileImageURL = profileImageURL
    username = domain.formState.userName
  }
}
