import IGListKit
import RxIGListKit

// MARK: - ProfileSectionModel

enum ProfileSectionModel {
  case information(itemModel: SectionDisplayModel<UserInformationSectionModel.Header, EmptyItemModel, EmptyItemModel>)
  case userContent(itemModel: SectionDisplayModel<ProfileContentSectionModel.Header, ProfileContentSectionModel.Cell, EmptyItemModel>)
}

// MARK: SectionModelType

extension ProfileSectionModel: SectionModelType {

  var object: ListDiffable {
    switch self {
    case let .information(itemModel):
      return itemModel
    case  let .userContent(itemModel):
      return itemModel
    }
  }
}
