import IGListKit
import RxIGListKit

// MARK: - CommentSectionModel

enum CommentSectionModel {
  case commentConent(itemModel: SectionDisplayModel<EmptyItemModel, CommentSectionItemModel.Cell, EmptyItemModel>)
}

// MARK: SectionModelType

extension CommentSectionModel: SectionModelType {

  var object: ListDiffable {
    switch self {
    case let .commentConent(itemModel):
      return itemModel
    }
  }
}
