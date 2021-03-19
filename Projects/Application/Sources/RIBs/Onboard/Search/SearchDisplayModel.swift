import Foundation

// MARK: - SearchDisplayModel

enum SearchDisplayModel {

  enum Action: Equatable {
    case load
    case typingSearch(String)
    case loading(Bool)
    case loadUser(SearchSectionItemModel.Cell)
  }

  enum Mutation: Equatable {
    case setLoading(Bool)
    case setError(String)
    case setUserContentSectionItemModel([SearchSectionItemModel.Cell])
    case setSearch(String)
  }

  struct State: DefaultValueUsable {
    var userContentSectionItemModel: SectionDisplayModel<EmptyItemModel, SearchSectionItemModel.Cell, EmptyItemModel>
    var tempUserContentSectionItemModel: SectionDisplayModel<EmptyItemModel, SearchSectionItemModel.Cell, EmptyItemModel>
    var isLoading: Bool
    var errorMessage: String

    static func defaultValue() -> Self {
      let userContentSectionItemModel = SectionDisplayModel<EmptyItemModel, SearchSectionItemModel.Cell, EmptyItemModel>.defaultValue()
      return State(
        userContentSectionItemModel: userContentSectionItemModel,
        tempUserContentSectionItemModel: userContentSectionItemModel,
        isLoading: false,
        errorMessage: "")
    }
  }

}
