import Foundation

enum SearchSectionItemModel {
  struct Cell: Equatable, DefaultValueUsable {

    // MARK: Lifecycle

    init(uid: String, avatarImageURL: String, userName: String, fullName: String) {
      self.uid = uid
      self.avatarImageURL = avatarImageURL
      self.userName = userName
      self.fullName = fullName
    }

    init() {
      uid = ""
      avatarImageURL = ""
      userName = ""
      fullName = ""
    }

    init(repositoryModel: UserRepositoryModel) {
      uid = repositoryModel.uid
      avatarImageURL = repositoryModel.uid
      userName = repositoryModel.username
      fullName = repositoryModel.fullname
    }

    // MARK: Internal

    var uid = ""
    var avatarImageURL = ""
    var userName = ""
    var fullName = ""

    static func defaultValue() -> SearchSectionItemModel.Cell {
      Cell()
    }
  }
}
