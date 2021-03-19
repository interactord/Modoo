import AsyncDisplayKit
import IGListKit

// MARK: - SingleHeaderSectionController

final class SectionController<ItemType: ListDiffable & SectionDisplayModeling>: ListSectionController, ASSectionController, ListSupplementaryViewSource, ASSupplementaryNodeSource {

  // MARK: Lifecycle

  init(
    elementKindTypes: [ElementKindType] = [],
    supplementaryViewHeaderBlockType: SupplementaryViewHeaderBlockType? = nil,
    supplementaryViewFooterBlockType: SupplementaryViewFooterBlockType? = nil,
    sizeForItemWidthBlock: SizeForItemWidthBlockType? = nil,
    nodeForItemBlock: NodeForItemBlockType? = nil,
    selectedCellItemBlock: SelectedCellItemBlockType? = nil)
  {
    self.elementKindTypes = elementKindTypes
    self.supplementaryViewHeaderBlockType = supplementaryViewHeaderBlockType
    self.supplementaryViewFooterBlockType = supplementaryViewFooterBlockType
    self.sizeForItemWidthBlock = sizeForItemWidthBlock
    self.nodeForItemBlock = nodeForItemBlock
    self.selectedCellItemBlock = selectedCellItemBlock
    super.init()
    supplementaryViewSource = self
  }

  deinit {
    print("SectionController deinit")
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

  typealias SupplementaryViewHeaderBlockType = (ItemType.HeaderType) -> ASCellNode
  typealias SupplementaryViewFooterBlockType = (ItemType.FooterType) -> ASCellNode
  typealias SizeForItemWidthBlockType = () -> CGFloat
  typealias NodeForItemBlockType = (ItemType.CellItemType) -> ASCellNode
  typealias SelectedCellItemBlockType = (ItemType.CellItemType) -> Void

  let elementKindTypes: [ElementKindType]

  var item: ItemType?
  var supplementaryViewHeaderBlockType: SupplementaryViewHeaderBlockType?
  var supplementaryViewFooterBlockType: SupplementaryViewFooterBlockType?
  var sizeForItemWidthBlock: SizeForItemWidthBlockType?
  var nodeForItemBlock: NodeForItemBlockType?
  var selectedCellItemBlock: SelectedCellItemBlockType?

  override func numberOfItems() -> Int {
    guard let item = item else { return .zero }
    return item.cellItems.count
  }

  override func didUpdate(to object: Any) {
    item = object as? ItemType
  }

  // MARK: ASSectionController

  func sizeRangeForItem(at index: Int) -> ASSizeRange {
    ASSizeRange(
      min: .zero,
      max: CGSize(width: sizeForItemWidthBlock?() ?? .infinity, height: .infinity))
  }

  // - Note: 직접호출 시, ASIGListSectionControllerMethods에서 크래시가 발생하여 테스트하지 못함
  override func cellForItem(at index: Int) -> UICollectionViewCell {
    ASIGListSectionControllerMethods.cellForItem(at: index, sectionController: self)
  }

  func nodeBlockForItem(at index: Int) -> ASCellNodeBlock {
    guard let item = item else { return  { ASCellNode() } }
    return { [weak self] in
      self?.nodeForItemBlock?(item.cellItems[index]) ?? ASCellNode()
    }
  }

  override func didSelectItem(at index: Int) {
    guard let item = item else { return }
    selectedCellItemBlock?(item.cellItems[index])
  }

  // MARK: ListSupplementaryViewSource

  // - Note: 직접호출 시, ASIGListSectionControllerMethods에서 크래시가 발생하여 테스트하지 못함
  func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
    ASIGListSupplementaryViewSourceMethods.viewForSupplementaryElement(ofKind: elementKind, at: index, sectionController: self)
  }

  // - Note: 직접호출 시, ASIGListSupplementaryViewSourceMethods에서 크래시가 발생하여 테스트하지 못함
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
    guard let item = item else { return { ASCellNode() } }
    return { [weak self] in
      switch elementKind {
      case UICollectionView.elementKindSectionHeader:
        return self?.supplementaryViewHeaderBlockType?(item.headerItem) ?? ASCellNode()
      case UICollectionView.elementKindSectionFooter:
        return self?.supplementaryViewFooterBlockType?(item.footerItem) ?? ASCellNode()
      default:
        return ASCellNode()
      }
    }
  }

}
