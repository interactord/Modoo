import Foundation

// MARK: - ProfileDisplayModel

enum ProfileDisplayModel {

  enum Action: Equatable {
    case load
    case loading(Bool)
    case logout
    case loadPost(ProfileContentSectionModel.Cell)
  }

  enum Mutation: Equatable {
    case setUserProfile(UserInformationSectionModel.Header)
    case setPosts([ProfileContentSectionModel.Cell])
    case setError(String)
    case setLoading(Bool)
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

// MARK: - MediaContentSectionItem

extension ProfileDisplayModel {

  enum MediaContentType: Equatable {
    case grid
    case list
    case bookmark
  }

  struct MediaContentSectionItem: Equatable {

    // MARK: Lifecycle

    init() {
      headerItem = HeaderItem()
      cellItems = []
    }

    init(headerItem: HeaderItem = .init(), cellItems: [CellItem]) {
      self.headerItem = headerItem
      self.cellItems = cellItems
    }

    // MARK: Internal

    struct HeaderItem: Equatable {
      var type: MediaContentType  = .grid
    }

    struct CellItem: Equatable {
      let id: String
      let imageURL: String
    }

    var headerItem: HeaderItem

    var cellItems: [CellItem]

  }
}

// MARK: - InformationSectionItem

extension ProfileDisplayModel {
}
