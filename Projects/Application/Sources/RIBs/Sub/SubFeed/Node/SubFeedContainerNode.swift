import AsyncDisplayKit
import RxSwift

// MARK: - SubFeedContainerNode

final class SubFeedContainerNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    defer {
      automaticallyManagesSubnodes = true
      automaticallyRelayoutOnSafeAreaChanges = true
    }
    super.init()
  }

  // MARK: Internal

  let headerNode = SubFeedHeaderNode()

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

extension SubFeedContainerNode {
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

// MARK: - Stream

extension SubFeedContainerNode {
  var backButtonTabStream: Observable<Void> {
    headerNode.backButtonTabStream
  }

  var titleUserNameBinder: Binder<String> {
    headerNode.titleUserNameBinder
  }

  var scrollToItemBinder: Binder<IndexPath> {
    Binder(self, scheduler: CurrentThreadScheduler.instance) { base, indexPath in
      base.collectionNode.scrollToItem(at: indexPath, at: .top, animated: false)
      base.collectionNode.isHidden = false
    }
  }
}
