import Foundation

struct PostReposityModel: Decodable, DictionaryModelType {
  let caption: String
  let likes: Int
  let imageURL: String
  let ownerUID: String
  let ownerProfileImageURL: String
  let ownerUserName: String
}
