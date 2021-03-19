import Foundation

enum FeedDisplayModel {

  enum Action: Equatable {
    case load
    case loading(Bool)
  }

  enum Mutation: Equatable {
    case setPostContentCellItems([FeedContentSectionModel.Cell])
    case setLoading(Bool)
    case setError(String)
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
