import IGListKit
import RxIGListKit

// MARK: - UserProfileSectionModel

enum UserProfileSectionModel {
  case userInformationSummery(itemModel: UserProfileInformationItem)
  case userContent(itemModel: UserProfileContentItem)
}

// MARK: SectionModelType

extension UserProfileSectionModel: SectionModelType {

  var object: ListDiffable {
    switch self {
    case let .userInformationSummery(itemModel):
      return itemModel
    case  let .userContent(itemModel):
      return itemModel
    }
  }
}
