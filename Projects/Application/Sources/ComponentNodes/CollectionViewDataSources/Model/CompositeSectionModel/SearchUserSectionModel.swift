import IGListKit
import RxIGListKit

// MARK: - SearchUserSectionModel

enum SearchUserSectionModel {
  case userContent(itemModel: SectionDisplayModel<EmptyItemModel, SearchSectionItemModel.Cell, EmptyItemModel>)
}

// MARK: SectionModelType

extension SearchUserSectionModel: SectionModelType {

  var object: ListDiffable {
    switch self {
    case  let .userContent(itemModel):
      return itemModel
    }
  }
}
