import IGListKit

// MARK: - ProfileContentSectionItemModel

enum ProfileContentSectionModel {
  enum HeaderType: Equatable {
    case grid
    case list
    case bookmark
  }

  struct Header: Equatable, DefaultValueUsable {
    var type = HeaderType.grid

    static func defaultValue() -> Self {
      Self.init()
    }
  }

  struct Cell: Equatable, DefaultValueUsable {
    let uid: String
    let model: PostReposityModel

    init(uid: String, postRepositoryModel: PostReposityModel) {
      self.uid = uid
      model = postRepositoryModel
    }

    static func defaultValue() -> Self {
      Self.init(uid: "", postRepositoryModel: .defaultValue())
    }
  }
}
