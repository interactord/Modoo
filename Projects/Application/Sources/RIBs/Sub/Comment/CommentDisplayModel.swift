import Foundation

enum CommentDisplayModel {

  enum Action: Equatable {
    case back
  }

  enum Mutation: Equatable {
  }

  struct State: Equatable, DefaultValueUsable {
    static func defaultValue() -> Self {
      Self()
    }
  }

}
