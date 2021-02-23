import AsyncDisplayKit

// MARK: - SubProfileContainerNode

final class SubProfileContainerNode: ASDisplayNode {

  override init() {
    super.init()
    automaticallyManagesSubnodes = true
  }

}

// MARK: - LayoutSpec

extension SubProfileContainerNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    ASLayoutSpec()
  }
}
