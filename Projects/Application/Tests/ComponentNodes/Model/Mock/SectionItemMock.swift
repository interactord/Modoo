import Foundation

@testable import Application

struct SectionItemMock: Equatable, Defaultable {
  let title: String

  static func `default`() -> SectionItemMock {
    self.init(title: "")
  }
}
