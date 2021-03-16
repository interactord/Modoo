import AsyncDisplayKit

// MARK: - ProfilePostCellNode

final class ProfilePostCellNode: ASCellNode {

  // MARK: Lifecycle

  init(item: ProfileDisplayModel.MediaContentSectionItem.CellItem) {
    defer{ automaticallyManagesSubnodes = true }
    self.item = item
    super.init()
  }

  deinit {
    print("ProfilePostCellNode deinit...")
  }

  // MARK: Internal

  lazy var photoNode: ASNetworkImageNode = {
    let node = ASNetworkImageNode()
    node.defaultImage = #imageLiteral(resourceName: "dummy-content-image")
    node.placeholderEnabled = true
    node.url = URL(string: item.imageURL)
    node.contentMode = .scaleAspectFill
    node.isLayerBacked = true
    return node
  }()

  let buttonNode = ASButtonNode()
  let item: ProfileDisplayModel.MediaContentSectionItem.CellItem
}

// MARK: - LayoutSpec

extension ProfilePostCellNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let ratioLayout = ASRatioLayoutSpec(ratio: 1, child: photoNode)
    return ASOverlayLayoutSpec(child: ratioLayout, overlay: buttonNode)
  }
}
