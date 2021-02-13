import AsyncDisplayKit

// MARK: - FeedHeaderNode

final class FeedHeaderNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    super.init()
    automaticallyManagesSubnodes = true
    backgroundColor = .clear
  }

  deinit {
    print("FeedHeaderNode deinit...")
  }

  // MARK: Internal

  let logoImageNode: ASImageNode = {
    let node = ASImageNode()
    node.image = #imageLiteral(resourceName: "instargram-logo")
    node.tintColor = .black
    node.style.preferredSize = Const.logoImageSize
    node.contentMode = .scaleAspectFill
    node.isLayerBacked = true
    return node
  }()

  let sendButtonNode: ASButtonNode = {
    let node = ASButtonNode()
    node.setImage(#imageLiteral(resourceName: "share-normal"), for: .normal)
    node.style.preferredSize = Const.buttonSize
    node.tintColor = .black
    return node
  }()

  // MARK: Private

  private struct Const {
    static let logoImageSize = CGSize(width: 94, height: 27)
    static let buttonSize = CGSize(width: 24, height: 24)
    static let contentPadding = UIEdgeInsets(top: 12, left: 12, bottom: 9, right: 12)
  }
}

// MARK: - LayoutSpec

extension FeedHeaderNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentLayout = ASStackLayoutSpec(
      direction: .horizontal,
      spacing: .zero,
      justifyContent: .spaceBetween, alignItems: .start,
      children: [
        logoImageNode,
        sendButtonNode,
      ])

    return ASInsetLayoutSpec(
      insets: Const.contentPadding,
      child: contentLayout)
  }
}
