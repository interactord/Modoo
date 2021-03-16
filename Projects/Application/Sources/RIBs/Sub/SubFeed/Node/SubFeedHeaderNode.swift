import AsyncDisplayKit

// MARK: - SubFeedHeaderNode

final class SubFeedHeaderNode: ASDisplayNode {

  override init() {
    defer { automaticallyManagesSubnodes = true }
    super.init()
  }

}

// MARK: - LayoutSpec

extension SubFeedHeaderNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    ASLayoutSpec()
  }
}
