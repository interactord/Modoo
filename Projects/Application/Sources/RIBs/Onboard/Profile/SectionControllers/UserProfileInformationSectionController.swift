import AsyncDisplayKit

// MARK: - UserProfileInformationSectionController

final class UserProfileInformationSectionController: ListSectionController, ASSectionController {

  // MARK: Lifecycle

  override init() {
    super.init()
    supplementaryViewSource = self
  }

  deinit {
    print("UserProfileInformationSectionController deinit...")
  }

  // MARK: Internal

  var item: UserProfileInformationItem?

  override func numberOfItems() -> Int {
    .zero
  }

  override func didUpdate(to object: Any) {
    item = object as? UserProfileInformationItem
  }

}

// MARK: ListSupplementaryViewSource

extension UserProfileInformationSectionController: ListSupplementaryViewSource {
  func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
    ASIGListSupplementaryViewSourceMethods.viewForSupplementaryElement(ofKind: elementKind, at: index, sectionController: self)
  }

  func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
    ASIGListSupplementaryViewSourceMethods.sizeForSupplementaryView(ofKind: elementKind, at: index)
  }

  func supportedElementKinds() -> [String] {
    [UICollectionView.elementKindSectionHeader]
  }
}

// MARK: ASSupplementaryNodeSource

extension UserProfileInformationSectionController: ASSupplementaryNodeSource {

  func nodeBlockForSupplementaryElement(ofKind elementKind: String, at index: Int) -> ASCellNodeBlock {
    { [weak self] in
      self?.nodeForSupplementaryElement(ofKind: elementKind, at: index) ?? ASCellNode()
    }
  }

  func nodeForSupplementaryElement(ofKind kind: String, at index: Int) -> ASCellNode {
    guard let item = self.item else { return ASCellNode() }
    return ProfileInformationCellNode(item: item)
  }

  func sizeRangeForSupplementaryElement(ofKind elementKind: String, at index: Int) -> ASSizeRange {
    guard elementKind == UICollectionView.elementKindSectionHeader else { return ASSizeRangeZero }
    return ASSizeRangeUnconstrained
  }
}
