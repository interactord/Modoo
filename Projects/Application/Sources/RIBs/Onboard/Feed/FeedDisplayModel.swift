import Foundation

enum FeedDisplayModel {

  enum Action: Equatable {
    case load
    case loading(Bool)
    case tabComment(FeedContentSectionModel.Cell)
  }

  enum Mutation: Equatable {
    case setLoading(Bool)
    case setError(String)
    case setPostContentCellItems([FeedContentSectionModel.Cell])
  }

  struct State: Equatable, DefaultValueUsable {
    var postContentSectionModel: SectionDisplayModel<EmptyItemModel, FeedContentSectionModel.Cell, EmptyItemModel>
    var isLoading: Bool
    var errorMessage: String

    static func defaultValue() -> Self {
      State(postContentSectionModel: .defaultValue(), isLoading: false, errorMessage: "")
    }
  }
}
