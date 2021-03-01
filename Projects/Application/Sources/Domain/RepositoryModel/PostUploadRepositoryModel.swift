import Foundation

// MARK: - PostUploadReposityModel

struct PostUploadReposityModel: Decodable, DictionaryModelType {
  let caption: String
  let likes: Int
  let imageURL: String
  let ownerUID: String
  let ownerProfileImageURL: String
  let ownerUserName: String
}

// MARK: Equatable

extension PostUploadReposityModel: Equatable {
}
