import Foundation

// MARK: - CommentRepositoryModel

struct CommentRepositoryModel: Decodable, DictionaryModelType, DefaultValueUsable {
  let uid: String
  let username: String
  let profileImageURL: String
  let commentText: String
  let timestamp: TimeInterval

  static func defaultValue() -> CommentRepositoryModel {
    Self.init(uid: "", username: "", profileImageURL: "", commentText: "", timestamp: .zero)
  }
}

// MARK: Equatable

extension CommentRepositoryModel: Equatable {
}
