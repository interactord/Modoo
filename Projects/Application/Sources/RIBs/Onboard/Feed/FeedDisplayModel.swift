import Foundation

enum FeedDisplayModel {

  enum Action {
    case load
    case loading(Bool)
  }

  enum Mutation: Equatable {
    case setPostContentSectionItem(FeedDisplayModel.PostContentSectionItem)
    case setLoading(Bool)
    case setError(String)
  }

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

      var timeStampDescription: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .full
        return formatter.string(from: Date(timeIntervalSince1970: timestamp), to: Date()) ?? ""
      }

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
