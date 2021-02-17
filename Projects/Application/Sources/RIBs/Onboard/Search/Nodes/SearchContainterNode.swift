import AsyncDisplayKit

// MARK: - SearchContainerNode

final class SearchContainerNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    super.init()

    automaticallyManagesSubnodes = true
    automaticallyRelayoutOnSafeAreaChanges = true
    backgroundColor = .white
  }

  deinit {
    print("SearchContainerNode deinit...")
  }

  // MARK: Internal

  let headerNode = SearchHeaderNode()

  let collectionNode: ASCollectionNode = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .vertical
    flowLayout.minimumLineSpacing = .zero
    flowLayout.minimumInteritemSpacing = .zero

    let node = ASCollectionNode(collectionViewLayout: flowLayout)
    node.registerSupplementaryNode(ofKind: UICollectionView.elementKindSectionHeader)
    node.alwaysBounceVertical = true
    node.style.flexGrow = 1
    node.backgroundColor = .red
    return node
  }()
}

// MARK: - LayoutSpec

extension SearchContainerNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contensLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: .zero,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        headerNode,
        collectionNode,
      ])

    return ASInsetLayoutSpec(insets: safeAreaInsets, child: contensLayout)
  }

}
