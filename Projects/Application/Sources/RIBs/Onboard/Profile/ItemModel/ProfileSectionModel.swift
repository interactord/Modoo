import IGListKit
import RxIGListKit

// MARK: - ProfileSectionModel

enum ProfileSectionModel {
  case userInformationSummery(itemModel: ProfileInformationSectionItemModel)
  case userContent(itemModel: ProfileContentSectionItemModel)
}

// MARK: SectionModelType

extension ProfileSectionModel: SectionModelType {

  var object: ListDiffable {
    switch self {
    case let .userInformationSummery(itemModel):
      return itemModel
    case  let .userContent(itemModel):
      return itemModel
    }
  }
}
