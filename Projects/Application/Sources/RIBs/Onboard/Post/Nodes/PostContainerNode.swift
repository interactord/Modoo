import AsyncDisplayKit
import RxSwift

// MARK: - PostContainerNode

final class PostContainerNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    super.init()

    automaticallyManagesSubnodes = true
    automaticallyRelayoutOnSafeAreaChanges = true

    backgroundColor = .white
  }

  deinit {
    print("PostContainerNode deinit...")
  }

  // MARK: Internal

  let headerNode = PostHeaderNode()
}

// MARK: - LayoutSpec

extension PostContainerNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentsLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: .zero,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        headerNode,
      ])

    return ASInsetLayoutSpec(
      insets: safeAreaInsets,
      child: contentsLayout)
  }
}

// MARK: - Stream

extension PostContainerNode {
  var cancelButtonTapStream: Observable<Void> {
    headerNode.cancelButton.rx.tap.asObservable()
  }
}
