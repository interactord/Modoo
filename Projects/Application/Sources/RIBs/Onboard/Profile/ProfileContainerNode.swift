import AsyncDisplayKit

// MARK: - ProfileContainerNode

final class ProfileContainerNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    super.init()

    automaticallyManagesSubnodes = true
    automaticallyRelayoutOnSafeAreaChanges = true
    backgroundColor = .white
  }

  deinit {
    print("ProfileContainerNode deinit...")
  }

  // MARK: Internal

  let headerNode = ProfileHeaderNode()

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
}

// MARK: - LayoutSpec

extension ProfileContainerNode {
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
