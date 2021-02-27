import Foundation

struct UserRepositoryModel: Decodable, DictionaryModelType {

  // MARK: Lifecycle

  init(domain: RegisterDisplayModel.State, uid: String, profileImageURL: String) {
    self.uid = uid
    email = domain.formState.email
    fullname = domain.formState.fullName
    self.profileImageURL = profileImageURL
    username = domain.formState.userName
  }

  init(uid: String, email: String, fullname: String, profileImageURL: String, username: String) {
    self.uid = uid
    self.email = email
    self.fullname = fullname
    self.profileImageURL = profileImageURL
    self.username = username
  }

  // MARK: Internal

  let uid: String
  let email: String
  let fullname: String
  let profileImageURL: String
  let username: String

}
