import Foundation

enum SubFeedDisplayModel {

  enum Action: Equatable {
    case tapClose
    case load
    case loading(Bool)
    case tabComment(FeedContentSectionModel.Cell)
  }

  enum Mutation: Equatable {
    case setLoading(Bool)
    case setError(String)
    case setPostContentCellItems([FeedContentSectionModel.Cell])
    case setFocusIndex(Int)
  }

  struct State: DefaultValueUsable {

    // MARK: Lifecycle

    init(cellModel: ProfileContentSectionModel.Cell, originalState: State) {
      self.cellModel = cellModel
      postContentSectionModel = originalState.postContentSectionModel
      isLoading = originalState.isLoading
      errorMessage = originalState.errorMessage
      focusIndex = originalState.focusIndex
    }

    init(postContentSectionItemModels: [FeedContentSectionModel.Cell], originalState: State = .defaultValue()) {
      cellModel = .defaultValue()
      postContentSectionModel = .init(cellItems: postContentSectionItemModels, original: originalState.postContentSectionModel)
      isLoading = originalState.isLoading
      errorMessage = originalState.errorMessage
      focusIndex = originalState.focusIndex
    }

    init() {
      cellModel = .defaultValue()
      postContentSectionModel = .defaultValue()
      isLoading = false
      errorMessage = ""
      focusIndex = -1
    }

    // MARK: Internal

    let cellModel: ProfileContentSectionModel.Cell
    var postContentSectionModel: SectionDisplayModel<EmptyItemModel, FeedContentSectionModel.Cell, EmptyItemModel>
    var isLoading: Bool
    var errorMessage: String
    var focusIndex: Int

    static func defaultValue() -> Self {
      State()
    }
  }
}
