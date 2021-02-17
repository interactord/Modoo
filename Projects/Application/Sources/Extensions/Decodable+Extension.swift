import Foundation

extension Decodable {
  init(from jsonObject: Any) throws {
    let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
    self = try JSONDecoder().decode(Self.self, from: jsonData)
  }
}
