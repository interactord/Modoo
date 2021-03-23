import Foundation

enum CommentSectionItemModel {
  struct Cell: Equatable {

    init(repositoryModel: CommentRepositoryModel) {
      model = repositoryModel
    }

    init() {
      model = CommentRepositoryModel.defaultValue()
    }

    let model: CommentRepositoryModel
  }
}
