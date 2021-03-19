import Foundation

// MARK: - PostReposityModel

struct PostReposityModel: Decodable, DictionaryModelType, DefaultValueUsable {
  let id: String
  let caption: String
  let likes: Int
  let imageURL: String
  let ownerUID: String
  let ownerProfileImageURL: String
  let ownerUserName: String
  let timestamp: TimeInterval

  static func defaultValue() -> PostReposityModel {
    Self.init(id: "", caption: "", likes: 0, imageURL: "", ownerUID: "", ownerProfileImageURL: "", ownerUserName: "", timestamp: .zero)
  }
}

// MARK: Equatable

extension PostReposityModel: Equatable {
}
