import Foundation

enum SearchSectionItemModel {
  struct Cell: Equatable {

    // MARK: Lifecycle

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
  }
}
