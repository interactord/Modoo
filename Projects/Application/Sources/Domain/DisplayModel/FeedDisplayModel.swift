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
      let caption: String
      let likes: Int
      let imageURL: String
      let ownerUID: String
      let ownerProfileImageURL: String
      let ownerUserName: String

      init(repositoryModel: PostReposityModel) {
        caption = repositoryModel.caption
        likes = repositoryModel.likes
        imageURL = repositoryModel.imageURL
        ownerUID = repositoryModel.ownerUID
        ownerProfileImageURL = repositoryModel.ownerProfileImageURL
        ownerUserName = repositoryModel.ownerUserName
      }

    }

    var items: [Item]
  }

  struct State: PresentableState {
    var postContentSectionModel: PostContentSectionModel

    static func initialState() -> State {
      State(postContentSectionModel: .init())
    }
  }
}
