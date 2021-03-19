import Foundation

@testable import Application

struct SectionItemMock: Equatable, DefaultValueUsable {
  let title: String

  static func defaultValue() -> Self {
    SectionItemMock(title: "")
  }
}
