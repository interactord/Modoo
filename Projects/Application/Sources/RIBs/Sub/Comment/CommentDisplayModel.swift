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
    case setCommentSectionItemModel([CommentSectionItemModel.Cell])
  }

  struct State: Equatable, DefaultValueUsable {

    // MARK: Lifecycle

    init(postItem: FeedContentSectionModel.Cell, oritinalState: Self) {
      self.postItem = postItem
      isLoading = oritinalState.isLoading
      errorMessage = oritinalState.errorMessage
      commentSectionItemModel = oritinalState.commentSectionItemModel
    }

    init(
      postItem: FeedContentSectionModel.Cell,
      commentSectionItemModel:SectionDisplayModel<EmptyItemModel, CommentSectionItemModel.Cell, EmptyItemModel>,
      isLoading: Bool,
      errorMessage: String)
    {
      self.postItem = postItem
      self.commentSectionItemModel = commentSectionItemModel
      self.isLoading = isLoading
      self.errorMessage = errorMessage
    }

    // MARK: Internal

    var postItem: FeedContentSectionModel.Cell
    var commentSectionItemModel: SectionDisplayModel<EmptyItemModel, CommentSectionItemModel.Cell, EmptyItemModel>
    var isLoading: Bool
    var errorMessage: String

    static func defaultValue() -> Self {
      Self(
        postItem: .defaultValue(),
        commentSectionItemModel: .defaultValue(),
        isLoading: false,
        errorMessage: "")
    }
  }

}
