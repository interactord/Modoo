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
    let id: String
    let imageURL: String

    static func defaultValue() -> Self {
      Self.init(id: "", imageURL: "")
    }
  }
}
