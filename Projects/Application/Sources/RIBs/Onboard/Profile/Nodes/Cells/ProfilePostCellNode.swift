import AsyncDisplayKit

// MARK: - ProfilePostCellNode

final class ProfilePostCellNode: ASCellNode {

  // MARK: Lifecycle

  override init() {
    super.init()
    automaticallyManagesSubnodes = true
  }

  deinit {
    print("ProfilePostCellNode deinit...")
  }

  // MARK: Internal

  let photoNode: ASImageNode = {
    let node = ASImageNode()
    node.image = #imageLiteral(resourceName: "dummy-content-image")
    node.contentMode = .scaleAspectFill
    node.isLayerBacked = true
    return node
  }()

  let buttonNode = ASButtonNode()

}

// MARK: - LayoutSpec

extension ProfilePostCellNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let ratioLayout = ASRatioLayoutSpec(ratio: 1, child: photoNode)
    return ASOverlayLayoutSpec(child: ratioLayout, overlay: buttonNode)
  }
}
