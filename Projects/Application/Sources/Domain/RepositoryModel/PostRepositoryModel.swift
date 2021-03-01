import Foundation

// MARK: - PostReposityModel

struct PostReposityModel: Decodable, DictionaryModelType {
  let id: String
  let caption: String
  let likes: Int
  let imageURL: String
  let ownerUID: String
  let ownerProfileImageURL: String
  let ownerUserName: String
  let timestamp: TimeInterval
}

// MARK: Equatable

extension PostReposityModel: Equatable {
}
