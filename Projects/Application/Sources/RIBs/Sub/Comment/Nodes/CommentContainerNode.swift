import AsyncDisplayKit
import RxSwift

// MARK: - CommentContainerNode

final class CommentContainerNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    super.init()

    automaticallyManagesSubnodes = true
    automaticallyRelayoutOnSafeAreaChanges = true
    backgroundColor = .white
  }

  deinit {
    print("CommentContainerNode deinit...")
  }

  // MARK: Internal

  let header = CommentHeaderNode()
  let collectionNode: ASCollectionNode = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .vertical
    flowLayout.minimumLineSpacing = .zero
    flowLayout.minimumInteritemSpacing = .zero

    let node = ASCollectionNode(collectionViewLayout: flowLayout)
    node.registerSupplementaryNode(ofKind: UICollectionView.elementKindSectionHeader)
    node.alwaysBounceVertical = true
    node.style.flexGrow = 1

    return node
  }()
}

// MARK: - LayoutSpec

extension CommentContainerNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: .zero,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        header,
        collectionNode,
      ])

    return ASInsetLayoutSpec(insets: safeAreaInsets, child: contentLayout)
  }
}

// MARK: - Stream

extension CommentContainerNode {
  var backButtonTapStream: Observable<Void> {
    header.backButtonTapStream
  }
}
