import Foundation

enum SubProfileDisplayModel {

  enum Action: Equatable {
    case load
    case loading(Bool)
    case back
    case follow
    case unFollow
  }

  enum Mutation: Equatable {
    case setUserProfile(ProfileDisplayModel.InformationSectionItem)
    case setPosts([ProfileDisplayModel.MediaContentSectionItem.CellItem])
    case setError(String)
    case setLoading(Bool)
    case setFollow(Bool)
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
