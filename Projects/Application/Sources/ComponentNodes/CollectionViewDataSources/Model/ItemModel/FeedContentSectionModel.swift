import IGListKit

// MARK: - ProfileContentSectionItemModel

enum FeedContentSectionModel {
  struct Cell: Equatable, Defaultable {

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

    static func `default`() -> Self {
      Self.init()
    }
  }
}
