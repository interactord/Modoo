import IGListKit

// MARK: - ProfileContentSectionItemModel

enum ProfileContentSectionModel {
  enum HeaderType: Equatable {
    case grid
    case list
    case bookmark
  }

  struct Header: Equatable, Defaultable {
    var type = HeaderType.grid

    static func `default`() -> Self {
      Self.init()
    }
  }

  struct Cell: Equatable, Defaultable {
    let id: String
    let imageURL: String

    static func `default`() -> Self {
      Self.init(id: "", imageURL: "")
    }
  }
}
