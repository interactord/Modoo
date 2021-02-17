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

  struct InformationDisplayModel: Equatable {
    var userName = ""
    var avatarImageURL = ""
    var postCount = ""
    var followingCount = ""
    var followerCount = ""
    var bioDescription = ""
  }

  struct State: PresentableState {
    var informationSectionModel: ProfileInformationItem
    var contentsSectionModel: ProfileContentItem
    var isLoading: Bool
    var errorMessage: String

    static func initialState() -> Self {
      let informationSectionModel = ProfileInformationItem(sectionID: UUID().hashValue, displayModel: .init())
      let contentsSectionModel = ProfileContentItem(sectionID: UUID().hashValue, displayModel: .init())
      return State(
        informationSectionModel: informationSectionModel,
        contentsSectionModel: contentsSectionModel,
        isLoading: false,
        errorMessage: "")
    }
  }

}
