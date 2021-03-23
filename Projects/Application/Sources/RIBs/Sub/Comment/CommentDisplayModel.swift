import Foundation

enum CommentDisplayModel {

  enum Action: Equatable {
    case back
    case load
    case loading(Bool)
  }

  enum Mutation: Equatable {
    case setLoading(Bool)
    case setError(String)
  }

  struct State: Equatable, DefaultValueUsable {

    // MARK: Lifecycle

    init(postItem: FeedContentSectionModel.Cell, oritinalState: Self) {
      self.postItem = postItem
      isLoading = oritinalState.isLoading
      errorMessage = oritinalState.errorMessage
    }

    init(postItem: FeedContentSectionModel.Cell, isLoading: Bool, errorMessage: String) {
      self.postItem = postItem
      self.isLoading = isLoading
      self.errorMessage = errorMessage
    }

    // MARK: Internal

    var postItem: FeedContentSectionModel.Cell
    var isLoading: Bool
    var errorMessage: String

    static func defaultValue() -> Self {
      Self(
        postItem: .defaultValue(),
        isLoading: false,
        errorMessage: "")
    }
  }

}
