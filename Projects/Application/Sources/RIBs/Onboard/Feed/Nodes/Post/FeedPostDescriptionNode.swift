import AsyncDisplayKit
import BonMot

// MARK: - FeedPostDescriptionNode

final class FeedPostDescriptionNode: ASDisplayNode {

  // MARK: Lifecycle

  init(item: FeedDisplayModel.PostContentSectionItem.Item) {
    self.item = item
    super.init()
    automaticallyManagesSubnodes = true
  }

  deinit {
    print("FeedPostDescriptionNode deinit...")
  }

  // MARK: Internal

  lazy var descriptionNode: ASTextNode = {
    let node = ASTextNode()
    node.maximumNumberOfLines = .zero
    node.attributedText = item.caption.styled(with: Const.descriptionTextStyle)
    return node
  }()
  lazy var likeInformationNode: ASTextNode = {
    let text = item.likes > 1 ? "\(item.likes) likes" : "\(item.likes) like"
    let node = ASTextNode()
    node.maximumNumberOfLines = 1
    node.attributedText = text.styled(with: Const.descriptionTextStyle)
    return node
  }()
  let item: FeedDisplayModel.PostContentSectionItem.Item

  // MARK: Private

  private struct Const {
    static let descriptionTextStyle = StringStyle(.font(.systemFont(ofSize: 12)), .color(.black))
    static let contentsLayout = UIEdgeInsets(top: 2, left: 12, bottom: 12, right: 10)
  }
}

// MARK: - layoutSpec

extension FeedPostDescriptionNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: .zero,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        likeInformationNode,
        descriptionNode,
      ])
    return ASInsetLayoutSpec(
      insets: Const.contentsLayout,
      child: contentLayout)
  }

}
