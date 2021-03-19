import Foundation

struct EmptyItemModel: Equatable, Defaultable {
  static func `default`() -> Self {
    Self.init()
  }
}
