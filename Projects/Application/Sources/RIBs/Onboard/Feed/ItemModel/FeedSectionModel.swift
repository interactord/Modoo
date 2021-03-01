import IGListKit
import RxIGListKit

// MARK: - FeedSectionModel

enum FeedSectionModel {
  case postContent(itemModel: PostContentSectionModel)
}

// MARK: SectionModelType

extension FeedSectionModel: SectionModelType {

  var object: ListDiffable {
    switch self {
    case  let .postContent(itemModel):
      return itemModel
    }
  }
}
