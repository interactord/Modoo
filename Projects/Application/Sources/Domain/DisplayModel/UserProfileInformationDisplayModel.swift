import Foundation

enum ProfileDisplayModel {

  enum MediaContentType {
    case grid
    case list
    case bookmark
  }

  struct MediaContentDisplayModel {
    let type: MediaContentType  = .grid
    let dummy = ""
  }

  struct InformationSectionItem: Equatable {

    // MARK: Lifecycle

    init(section: Section) {
      self.section = section
    }

    init(repositoryModel: UserRepositoryModel) {
      let section = Section(
        userName: repositoryModel.username,
        avatarImageURL: repositoryModel.profileImageURL,
        postCount: "0",
        followingCount: "0",
        followerCount: "0",
        bioDescription: "")

      self.init(section: section)
    }

    // MARK: Internal

    struct Section: Equatable {
      var userName = ""
      var avatarImageURL = ""
      var postCount = ""
      var followingCount = ""
      var followerCount = ""
      var bioDescription = ""
    }

    var section = Section()

  }

  struct State: PresentableState {
    var informationSectionModel: ProfileInformationItem
    var contentsSectionModel: ProfileContentItem
    var isLoading: Bool
    var errorMessage: String

    static func initialState() -> Self {
      let informationSectionModel = ProfileInformationItem()
      let contentsSectionModel = ProfileContentItem()
      return State(
        informationSectionModel: informationSectionModel,
        contentsSectionModel: contentsSectionModel,
        isLoading: false,
        errorMessage: "")
    }
  }

}
