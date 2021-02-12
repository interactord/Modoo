import AsyncDisplayKit

// MARK: - FeedContainerNode

final class FeedContainerNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    super.init()

    automaticallyManagesSubnodes = true
    automaticallyRelayoutOnSafeAreaChanges = true
  }

  deinit {
    print("FeedContainerNode deinit...")
  }

  // MARK: Internal

  let collectionNode: ASCollectionNode = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .vertical
    flowLayout.minimumLineSpacing = .zero
    flowLayout.minimumInteritemSpacing = .zero

    let node = ASCollectionNode(collectionViewLayout: flowLayout)
    node.alwaysBounceVertical = true
    node.style.flexGrow = 1
    return node
  }()

  let headerNode = FeedHeaderNode()
}

// MARK: - LayoutSpec

extension FeedContainerNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentsLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: .zero,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        headerNode,
        collectionNode,
      ])

    return ASInsetLayoutSpec(
      insets: safeAreaInsets,
      child: contentsLayout)
  }
}
