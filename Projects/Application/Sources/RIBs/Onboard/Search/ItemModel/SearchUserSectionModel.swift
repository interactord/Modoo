import IGListKit
import RxIGListKit

// MARK: - SearchUserSectionModel

enum SearchUserSectionModel {
  case userContent(itemModel: SearchUserContentItemModel)
}

// MARK: SectionModelType

extension SearchUserSectionModel: SectionModelType {
  var object: ListDiffable {
    switch self {
    case let .userContent(itemModel: itemModel):
      return itemModel
    }
  }
}
