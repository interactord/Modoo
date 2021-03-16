import AsyncDisplayKit

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

  let headerNode = SubPostsHeaderNode()

}

// MARK: - LayoutSpec

extension SubFeedContainerNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    ASLayoutSpec()
  }
}
