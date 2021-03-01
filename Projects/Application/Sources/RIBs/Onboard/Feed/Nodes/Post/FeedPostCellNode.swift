import AsyncDisplayKit
import BonMot

// MARK: - FeedPostCellNode

final class FeedPostCellNode: ASCellNode {

  // MARK: Lifecycle

  init(item: FeedDisplayModel.PostContentSectionItem.Item) {
    self.item = item
    super.init()
    automaticallyManagesSubnodes = true
    backgroundColor = .white
  }

  deinit {
    print("FeedPostCellNode deinit...")
  }

  // MARK: Internal

  lazy var headerNode: FeedPostHeaderNode = {
    FeedPostHeaderNode(item: item)
  }()
  let actionNode = FeedActionNode()
  lazy var pictureImageNode: ASNetworkImageNode = {
    let node = ASNetworkImageNode()
    node.defaultImage = #imageLiteral(resourceName: "dummy-content-image")
    node.placeholderEnabled = true
    node.url = URL(string: item.imageURL)
    node.contentMode = .scaleAspectFill
    return node
  }()
  lazy var descriptionNode: FeedPostDescriptionNode = {
    FeedPostDescriptionNode(item: item)
  }()
  let item: FeedDisplayModel.PostContentSectionItem.Item

  // MARK: Private

  private struct Const {
  }

}

// MARK: - LayoutSpec

extension FeedPostCellNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .vertical,
      spacing: .zero,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        headerNode,
        pictureAreaLayoutSpec(),
        actionNode,
        descriptionNode,
      ])
  }

  func pictureAreaLayoutSpec() -> ASLayoutSpec {
    ASRatioLayoutSpec(ratio: 1 / 1.5, child: pictureImageNode)
  }
}
