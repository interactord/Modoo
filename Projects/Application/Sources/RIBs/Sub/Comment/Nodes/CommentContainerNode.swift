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
}

// MARK: - LayoutSpec

extension CommentContainerNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let flexibleSpacer = ASLayoutSpec()
    flexibleSpacer.style.flexGrow = 1
    let contentLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: .zero,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        header,
        flexibleSpacer,
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
