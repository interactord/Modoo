import Foundation

// MARK: - CellItemUsable

protocol CellItemUsable {
  associatedtype ItemType

  var items: [ItemType] { get }
}

// MARK: - SearchDisplayModel

enum SearchDisplayModel {

  struct SearchContentSectionItem: CellItemUsable, Equatable {

    // MARK: Lifecycle

    init(items: [Item]) {
      self.items = items
    }

    init() {
      items = []
    }

    init(repositoryModels: [UserRepositoryModel]) {
      items = repositoryModels.map { model in
        Item(
          avatarImageURL: model.profileImageURL,
          userName: model.username,
          fullName: model.username)
      }
    }

    // MARK: Internal

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
