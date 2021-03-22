import AsyncDisplayKit
import RxSwift

// MARK: - CommentContainerNode

final class CommentContainerNode: ASDisplayNode {

  override init() {
    super.init()

    automaticallyManagesSubnodes = true
    automaticallyRelayoutOnSafeAreaChanges = true
    backgroundColor = .white
  }

  deinit {
    print("CommentContainerNode deinit...")
  }

}

// MARK: - LayoutSpec

extension CommentContainerNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    ASStackLayoutSpec()
  }
}
