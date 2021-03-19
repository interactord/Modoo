import Foundation

enum SubFeedDisplayModel {

  enum Action: Equatable {
    case tapClose
    case load
    case loading(Bool)
  }

  enum Mutation: Equatable {
    case setLoading(Bool)
    case setError(String)
  }

  struct State: DefaultValueUsable {
    let cellModel: ProfileContentSectionModel.Cell
    var postContentSectionModel: SectionDisplayModel<EmptyItemModel, FeedContentSectionModel.Cell, EmptyItemModel>
    var isLoading: Bool
    var errorMessage: String

    static func defaultValue() -> Self {
      State(cellModel: .defaultValue(), postContentSectionModel: .defaultValue(), isLoading: false, errorMessage: "")
    }
  }
}
