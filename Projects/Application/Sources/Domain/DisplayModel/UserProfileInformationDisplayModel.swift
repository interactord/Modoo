import Foundation

enum ProfileDisplayModel {

  enum MediaContentType: Equatable {
    case grid
    case list
    case bookmark
  }

  struct MediaContentSectionItem: Equatable {
    struct HeaderItem: Equatable {
      var type: MediaContentType  = .grid
    }

    init() {
      headerItem = HeaderItem()
    }

    var headerItem: HeaderItem

  }

  struct InformationSectionItem: Equatable {

    // MARK: Lifecycle

    init(headerItem: HeaderItem) {
      self.headerItem = headerItem
    }

    init(userRepositoryModel: UserRepositoryModel, socialRepositoryModel: UserSocialRepositoryModel, isFollowed: Bool = false) {
      let headerItem = HeaderItem(
        userName: userRepositoryModel.username,
        avatarImageURL: userRepositoryModel.profileImageURL,
        postCount: "0",
        followingCount: "\(socialRepositoryModel.following)",
        followerCount: "\(socialRepositoryModel.followers)",
        bioDescription: "",
        isFollowed: isFollowed)

      self.init(headerItem: headerItem)
    }

    init() {
      headerItem = HeaderItem()
    }

    // MARK: Internal

    struct HeaderItem: Equatable {
      var userName = ""
      var avatarImageURL = ""
      var postCount = ""
      var followingCount = ""
      var followerCount = ""
      var bioDescription = ""
      var isFollowed = false
    }

    var headerItem: HeaderItem
    var cellItems: [String] = []

  }

  struct State: PresentableState {
    var informationSectionItemModel: ProfileInformationSectionItemModel
    var contentsSectionItemModel: ProfileContentSectionItemModel
    var isLoading: Bool
    var errorMessage: String

    static func initialState() -> Self {
      let informationSectionItemModel = ProfileInformationSectionItemModel()
      let contentsSectionItemModel = ProfileContentSectionItemModel()
      return State(
        informationSectionItemModel: informationSectionItemModel,
        contentsSectionItemModel: contentsSectionItemModel,
        isLoading: false,
        errorMessage: "")
    }
  }

}
