import AsyncDisplayKit
import BonMot

// MARK: - FeedPostCellNode

final class FeedPostCellNode: ASCellNode {

  // MARK: Lifecycle

  override init() {
    super.init()
    automaticallyManagesSubnodes = true
    backgroundColor = .white
  }

  deinit {
    print("FeedPostCellNode deinit...")
  }

  // MARK: Internal

  let headerNode = FeedPostHeaderNode()
  let actionNode = FeedActionNode()
  let pictureImageNode: ASImageNode = {
    let node = ASImageNode()
    node.image = #imageLiteral(resourceName: "dummy-content-image")
    node.contentMode = .scaleAspectFill
    node.style.width = .init(unit: .fraction, value: 1.0)
    return node
  }()
  let descriptionNode = FeedPostDescriptionNode()

  // MARK: Private

  private struct Const {
  }
}

// MARK: - LayoutSpec

extension FeedPostCellNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    style.width = .init(unit: .fraction, value: 1.0)

    return ASStackLayoutSpec(
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
