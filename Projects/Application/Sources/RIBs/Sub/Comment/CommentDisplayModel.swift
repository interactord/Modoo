import Foundation

enum CommentDisplayModel {

  enum Action: Equatable {
    case back
  }

  enum Mutation: Equatable {
  }

  struct State: Equatable, DefaultValueUsable {
    var postItem: FeedContentSectionModel.Cell

    static func defaultValue() -> Self {
      Self(postItem: .defaultValue())
    }
  }

}
