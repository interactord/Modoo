import AsyncDisplayKit
import IGListKit

// MARK: - SingleHeaderSectionController

final class SingleHeaderSectionController<ItemType: ListDiffable>: ListSectionController, ASSectionController, ListSupplementaryViewSource, ASSupplementaryNodeSource {

  // MARK: Lifecycle

  init(elementKindTypes: [ElementKindType], supplementaryViewBlock: @escaping SupplementaryViewBlockType) {
    self.elementKindTypes = elementKindTypes
    self.supplementaryViewBlock = supplementaryViewBlock
    super.init()
    supplementaryViewSource = self
  }

  deinit {
    print("SingleHeaderSectionController deinit")
  }

  // MARK: Internal

  enum ElementKindType: String {
    case header
    case footer

    var rawValue: String {
      switch self {
      case .header: return UICollectionView.elementKindSectionHeader
      case .footer: return UICollectionView.elementKindSectionFooter
      }
    }
  }

  typealias SupplementaryViewBlockType = ((kind: String, index: Int, item: ItemType)) -> ASCellNode

  let elementKindTypes: [ElementKindType]

  var item: ItemType?
  var supplementaryViewBlock: SupplementaryViewBlockType

  override func numberOfItems() -> Int { .zero }

  override func didUpdate(to object: Any) {
    item = object as? ItemType
  }

  // MARK: ListSupplementaryViewSource

  func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
    ASIGListSupplementaryViewSourceMethods.viewForSupplementaryElement(
      ofKind: elementKind,
      at: index,
      sectionController: self)
  }

  // - Note: 테스트하지 못함
  func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
    ASIGListSupplementaryViewSourceMethods.sizeForSupplementaryView(ofKind: elementKind, at: index)
  }

  func supportedElementKinds() -> [String] {
    elementKindTypes.map { $0.rawValue }
  }

  // MARK: ASSupplementaryNodeSource

  func sizeRangeForSupplementaryElement(ofKind elementKind: String, at index: Int) -> ASSizeRange {
    guard supportedElementKinds().contains(elementKind) else { return ASSizeRangeZero }
    return ASSizeRangeUnconstrained
  }

  func nodeBlockForSupplementaryElement(ofKind elementKind: String, at index: Int) -> ASCellNodeBlock {
    { [weak self] in
      self?.nodeForSupplementaryElement(ofKind: elementKind, at: index) ?? ASCellNode()
    }
  }

  func nodeForSupplementaryElement(ofKind kind: String, at index: Int) -> ASCellNode {
    guard let item = item else { return ASCellNode() }
    return supplementaryViewBlock((kind: kind, index: index, item: item))
  }

}
