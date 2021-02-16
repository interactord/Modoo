import IGListKit
import RxIGListKit

// MARK: - ProfileSectionModel

enum ProfileSectionModel {
  case userInformationSummery(itemModel: ProfileInformationItem)
  case userContent(itemModel: ProfileContentItem)
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
