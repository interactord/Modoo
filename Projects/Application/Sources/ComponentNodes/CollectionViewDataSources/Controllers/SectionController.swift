import AsyncDisplayKit
import IGListKit

// MARK: - SingleHeaderSectionController

final class SectionController<ItemType: ListDiffable>: ListSectionController, ASSectionController, ListSupplementaryViewSource, ASSupplementaryNodeSource {

  // MARK: Lifecycle

  init(
    elementKindTypes: [ElementKindType] = [],
    supplementaryViewBlock: SupplementaryViewBlockType? = nil,
    numberOfCellItemsBlock: NumberOfItemsBlockType? = nil,
    sizeForItemWidthBlock: SizeForItemWidthBlockType? = nil,
    nodeForItemBlock: NodeForItemBlockType? = nil)
  {
    self.elementKindTypes = elementKindTypes
    self.supplementaryViewBlock = supplementaryViewBlock
    self.numberOfCellItemsBlock = numberOfCellItemsBlock
    self.sizeForItemWidthBlock = sizeForItemWidthBlock
    self.nodeForItemBlock = nodeForItemBlock
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

  typealias SupplementaryViewBlockType = ((kind: String, index: Int, item: ItemType)) -> ASCellNode
  typealias NumberOfItemsBlockType = (ItemType) -> Int
  typealias SizeForItemWidthBlockType = () -> CGFloat
  typealias NodeForItemBlockType = ((index: Int, item: ItemType)) -> ASCellNode

  let elementKindTypes: [ElementKindType]

  var item: ItemType?
  var supplementaryViewBlock: SupplementaryViewBlockType?
  var numberOfCellItemsBlock: NumberOfItemsBlockType?
  var sizeForItemWidthBlock: SizeForItemWidthBlockType?
  var nodeForItemBlock: NodeForItemBlockType?

  override func numberOfItems() -> Int {
    guard let item = item else { return .zero }
    return numberOfCellItemsBlock?(item) ?? .zero
  }

  override func didUpdate(to object: Any) {
    item = object as? ItemType
  }

  // MARK: ASSectionController

  // - Note: 직접호출 시, ASIGListSectionControllerMethods에서 크래시가 발생하여 테스트하지 못함
  override func sizeForItem(at index: Int) -> CGSize {
    ASIGListSectionControllerMethods.sizeForItem(at: index)
  }

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
      self?.nodeForItemBlock?((index: index, item: item)) ?? ASCellNode()
    }
  }

  // MARK: ListSupplementaryViewSource

  // - Note: 직접호출 시, ASIGListSectionControllerMethods에서 크래시가 발생하여 테스트하지 못함
  func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
    ASIGListSupplementaryViewSourceMethods.viewForSupplementaryElement(
      ofKind: elementKind,
      at: index,
      sectionController: self)
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
      self?.supplementaryViewBlock?((kind: elementKind, index: index, item: item)) ?? ASCellNode()
    }
  }

}
