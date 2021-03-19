import Foundation

enum FeedDisplayModel {

  enum Action {
    case load
    case loading(Bool)
  }

  enum Mutation: Equatable {
    case setPostContentCellItems([FeedContentSectionModel.Cell])
    case setLoading(Bool)
    case setError(String)
  }

  struct State: PresentableState {
    var postContentSectionModel: SectionDisplayModel<EmptyItemModel, FeedContentSectionModel.Cell, EmptyItemModel>
    var isLoading: Bool
    var errorMessage: String

    static func initialState() -> State {
      State(postContentSectionModel: .default(), isLoading: false, errorMessage: "")
    }
  }
}
