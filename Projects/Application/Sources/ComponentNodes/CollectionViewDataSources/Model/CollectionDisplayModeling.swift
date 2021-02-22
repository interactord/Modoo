import Foundation

protocol CollectionDisplayModeling {
  associatedtype HeaderType
  associatedtype CellItemType
  associatedtype FooterType

  var sectionID: String { get }
  var headerItem: HeaderType { get }
  var cellItems: [CellItemType] { get }
  var footerItem: FooterType { get }
}
