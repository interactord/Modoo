import AsyncDisplayKit
import RxSwift

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

  let headerNode = ProfileHeaderNode()

}

// MARK: - LayoutSpec

extension ProfileContainerNode {
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

    return ASInsetLayoutSpec(insets: safeAreaInsets, child: contentsLayout)
  }
}

// MARK: - Stream

extension ProfileContainerNode {

  var titleBinder: Binder<String> {
    headerNode.titleBinder
  }

  var moreButtonTapStream: Observable<Void> {
    headerNode.moreButtonTapStream
  }

}
