import Foundation

enum SubProfileDisplayModel {

  enum Action: Equatable {
    case load
    case loading(Bool)
    case back
    case follow
    case unFollow
    case loadPost(ProfileContentSectionModel.Cell)
  }

  enum Mutation: Equatable {
    case setUserProfile(UserInformationSectionModel.Header)
    case setPosts([ProfileContentSectionModel.Cell])
    case setError(String)
    case setLoading(Bool)
    case setFollow(Bool)
  }

  struct State: Equatable, DefaultValueUsable {
    var informationSectionItemModel: SectionDisplayModel<UserInformationSectionModel.Header, EmptyItemModel, EmptyItemModel>
    var contentsSectionItemModel: SectionDisplayModel<ProfileContentSectionModel.Header, ProfileContentSectionModel.Cell, EmptyItemModel>
    var isLoading: Bool
    var errorMessage: String

    static func defaultValue() -> Self {
      let informationSectionItemModel = SectionDisplayModel<UserInformationSectionModel.Header, EmptyItemModel, EmptyItemModel>.defaultValue()
      let contentsSectionItemModel = SectionDisplayModel<ProfileContentSectionModel.Header, ProfileContentSectionModel.Cell, EmptyItemModel>.defaultValue()
      return State(
        informationSectionItemModel: informationSectionItemModel,
        contentsSectionItemModel: contentsSectionItemModel,
        isLoading: false,
        errorMessage: "")
    }
  }
}
