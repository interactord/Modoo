import AsyncDisplayKit
import BonMot

// MARK: - CommentCellNode

final class CommentCellNode: ASCellNode {

  // MARK: Lifecycle

  init(item: CommentSectionItemModel.Cell) {
    self.item = item
    super.init()
    automaticallyManagesSubnodes = true
    backgroundColor = .white
  }

  deinit {
    print("CommentCellNode deinit...")
  }

  // MARK: Internal

  let item: CommentSectionItemModel.Cell

  lazy var profileImageNode: ASNetworkImageNode = {
    let node = ASNetworkImageNode()
    node.style.preferredSize = Const.buttonSize
    node.cornerRadius = Const.buttonSize.width / 2
    node.defaultImage = #imageLiteral(resourceName: "dummy-content-image")
    node.placeholderEnabled = true
    node.url = URL(string: item.model.profileImageURL)
    node.contentMode = .scaleAspectFill
    node.isLayerBacked = true
    return node
  }()

  lazy var commentNode: ASTextNode = {
    let node = ASTextNode()
    node.maximumNumberOfLines = 0
    node.attributedText = NSAttributedString.composed(of: [
      item.model.username.styled(with: Const.userNameStyle),
      " ".styled(with: Const.commentStyle),
      item.model.commentText.styled(with: Const.commentStyle),
    ])
    return node
  }()

  // MARK: Private

  private struct Const {
    static let buttonSize = CGSize(width: 16.0, height: 16.0)
    static let userNameStyle = StringStyle(.font(.systemFont(ofSize: 12, weight: .bold)), .color(.black))
    static let commentStyle = StringStyle(.font(.systemFont(ofSize: 12, weight: .medium)), .color(.black))
    static let contentSpacing: CGFloat = 6.0
    static let contentsPadding = UIEdgeInsets(top: 12.5, left: 12, bottom: 12, right: 12)
  }
}

// MARK: - LayoutSpec

extension CommentCellNode {

  // MARK: Internal

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: .zero,
      justifyContent: .start,
      alignItems: .stretch,
      children: [contentAreaLayoutSpec()])

    contentLayout.style.width = .init(unit: .fraction, value: 1)

    return ASInsetLayoutSpec(
      insets: Const.contentsPadding,
      child: contentLayout)
  }

  // MARK: Private

  private func contentAreaLayoutSpec() -> ASLayoutSpec {
    let flexibleSpacer = ASLayoutSpec()
    flexibleSpacer.style.flexGrow = 1

    let contentLayout = ASStackLayoutSpec(
      direction: .horizontal,
      spacing: Const.contentSpacing,
      justifyContent: .center,
      alignItems: .stretch,
      children: [
        profileImageNode,
        commentNode,
        flexibleSpacer,
      ])

    return contentLayout
  }
}
