import Foundation

enum SearchDisplayModel {

  struct SearchContentSectionItem: Equatable {
    struct Item: Equatable {
      var avatarImageURL = ""
      var userName = ""
      var fullName = ""
    }

    var items: [Item]
  }

  struct State: PresentableState {
    var userContentSectionItemModel: SearchUserContentSectionItemModel
    var isLoading: Bool
    var errorMessage: String

    static func initialState() -> State {
      let userContentSectionItemModel = SearchUserContentSectionItemModel()
      return State(
        userContentSectionItemModel: userContentSectionItemModel,
        isLoading: false,
        errorMessage: "")
    }
  }

}
