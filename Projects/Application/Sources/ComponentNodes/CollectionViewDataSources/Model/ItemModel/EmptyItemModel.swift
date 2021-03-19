import Foundation

struct EmptyItemModel: Equatable, DefaultValueUsable {
  static func defaultValue() -> Self {
    Self.init()
  }
}
