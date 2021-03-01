import Foundation

enum FeedDisplayModel {

  struct PostContentSectionItem: Equatable {

    // MARK: Lifecycle

    init(postRepositoryModels: [PostReposityModel]) {
      items = postRepositoryModels.map {
        Item(repositoryModel: $0)
      }
    }

    // MARK: Internal

    struct Item: Equatable {

      // MARK: Lifecycle

      init(repositoryModel: PostReposityModel) {
        id = repositoryModel.id
        caption = repositoryModel.caption
        likes = repositoryModel.likes
        imageURL = repositoryModel.imageURL
        ownerUID = repositoryModel.ownerUID
        ownerProfileImageURL = repositoryModel.ownerProfileImageURL
        ownerUserName = repositoryModel.ownerUserName
        timestamp = repositoryModel.timestamp
      }

      init() {
        id = ""
        caption = ""
        likes = 0
        imageURL = ""
        ownerUID = ""
        ownerProfileImageURL = ""
        ownerUserName = ""
        timestamp = .zero
      }

      // MARK: Internal

      let id: String
      let caption: String
      let likes: Int
      let imageURL: String
      let ownerUID: String
      let ownerProfileImageURL: String
      let ownerUserName: String
      let timestamp: TimeInterval

    }

    var items: [Item]
  }

  struct State: PresentableState {
    var postContentSectionModel: PostContentSectionModel
    var isLoading: Bool
    var errorMessage: String

    static func initialState() -> State {
      State(postContentSectionModel: .init(), isLoading: false, errorMessage: "")
    }
  }
}
