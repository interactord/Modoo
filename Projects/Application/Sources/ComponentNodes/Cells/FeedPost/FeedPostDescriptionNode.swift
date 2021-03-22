import AsyncDisplayKit
import BonMot

// MARK: - FeedPostDescriptionNode

final class FeedPostDescriptionNode: ASDisplayNode {

  // MARK: Lifecycle

  init(item: FeedContentSectionModel.Cell) {
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
    node.attributedText = item.caption.styled(with: Const.descriptionStyle)
    return node
  }()
  lazy var likeInformationNode: ASTextNode = {
    let text = item.likes > 1 ? "\(item.likes) likes" : "\(item.likes) like"
    let node = ASTextNode()
    node.maximumNumberOfLines = 1
    node.attributedText = text.styled(with: Const.descriptionStyle)
    return node
  }()
  lazy var timeNode: ASTextNode = {
    let node = ASTextNode()
    node.maximumNumberOfLines = 1
    node.attributedText = "\(item.timeStampDescription) ago".styled(with: Const.timeStyle)
    return node
  }()
  let item: FeedContentSectionModel.Cell

  // MARK: Private

  private struct Const {
    static let descriptionStyle = StringStyle(.font(.systemFont(ofSize: 12)), .color(.black))
    static let timeStyle = StringStyle(.font(.systemFont(ofSize: 12)), .color(#colorLiteral(red: 0.6156862745, green: 0.6156862745, blue: 0.6156862745, alpha: 1)))
    static let contentsLayout = UIEdgeInsets(top: 2, left: 12, bottom: 12, right: 10)
    static let contentsSpacing: CGFloat = 3.0
  }
}

// MARK: - layoutSpec

extension FeedPostDescriptionNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: Const.contentsSpacing,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        likeInformationNode,
        descriptionNode,
        timeNode,
      ])
    return ASInsetLayoutSpec(
      insets: Const.contentsLayout,
      child: contentLayout)
  }

}
