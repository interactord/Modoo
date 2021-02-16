import IGListKit

// MARK: - SingleHeaderItemMock

final class SingleHeaderItemMock {

  // MARK: Lifecycle

  init(id: String, title: String) {
    self.id = id
    self.title = title
  }

  // MARK: Internal

  let id: String
  let title: String

}

// MARK: ListDiffable

extension SingleHeaderItemMock: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    id as NSObjectProtocol
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard let item = object as? SingleHeaderItemMock else { return false }
    return id == item.id
      && title == item.title
  }
}
