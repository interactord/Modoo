import Foundation

// MARK: - CellItemUsable

protocol CellItemUsable {
  associatedtype ItemType

  var items: [ItemType] { get }
}

// MARK: - SearchDisplayModel

enum SearchDisplayModel {

  enum Action: Equatable {
    case load
    case typingSearch(String)
    case loading(Bool)
    case loadUser(SearchDisplayModel.SearchContentSectionItem.Item)
  }

  enum Mutation: Equatable {
    case setLoading(Bool)
    case setError(String)
    case setUserContentSectionItemModel(SearchDisplayModel.SearchContentSectionItem)
    case setSearch(String)
  }

  struct State: DefaultValueUsable {
    var userContentSectionItemModel: SearchUserContentSectionItemModel
    var tempUserContentSectionItemModel: SearchUserContentSectionItemModel
    var isLoading: Bool
    var errorMessage: String

    static func defaultValue() -> Self {
      let userContentSectionItemModel = SearchUserContentSectionItemModel()
      return State(
        userContentSectionItemModel: userContentSectionItemModel,
        tempUserContentSectionItemModel: userContentSectionItemModel,
        isLoading: false,
        errorMessage: "")
    }
  }

}

// MARK: - SearchContentSectionItem

extension SearchDisplayModel {

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
          uid: model.uid,
          avatarImageURL: model.profileImageURL,
          userName: model.username,
          fullName: model.username)
      }
    }

    // MARK: Internal

    struct Item: Equatable {
      var uid = ""
      var avatarImageURL = ""
      var userName = ""
      var fullName = ""
    }

    var items: [Item]

  }

}
