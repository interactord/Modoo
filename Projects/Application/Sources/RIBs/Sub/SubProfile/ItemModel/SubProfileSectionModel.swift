import IGListKit
import RxIGListKit

// MARK: - SubProfileSectionModel

enum SubProfileSectionModel {
  case userInformationSummery(itemModel: ProfileInformationSectionItemModel)
  case userContent(itemModel: ProfileContentSectionItemModel)
}

// MARK: SectionModelType

extension SubProfileSectionModel: SectionModelType {

  var object: ListDiffable {
    switch self {
    case let .userInformationSummery(itemModel):
      return itemModel
    case let .userContent(itemModel):
      return itemModel
    }
  }
}
