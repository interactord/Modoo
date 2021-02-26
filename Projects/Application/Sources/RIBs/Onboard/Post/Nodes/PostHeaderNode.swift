import AsyncDisplayKit
import BonMot

// MARK: - PostHeaderNode

final class PostHeaderNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    super.init()
    automaticallyManagesSubnodes = true
  }

  deinit {
    print("PostHeaderNode deinit...")
  }

  // MARK: Internal

  let cancelButton: ASButtonNode = {
    let node = ASButtonNode()
    node.imageNode.style.preferredSize = Const.cacelButtonSize
    node.setImage(#imageLiteral(resourceName: "cacel-icon"), for: .normal)
    node.tintColor = Const.buttonTintColor
    return node
  }()

  let shareButton: ASButtonNode = {
    let node = ASButtonNode()
    node.setAttributedTitle("Share".styled(with: Const.normalStateOfButtonTitleStyle), for: .normal)
    node.setAttributedTitle("Share".styled(with: Const.disabledStateOfButtonTitleStyle), for: .disabled)
    node.tintColor = Const.buttonTintColor
    return node
  }()

  let titleNode: ASTextNode = {
    let node = ASTextNode()
    node.maximumNumberOfLines = 1
    node.attributedText = "New Post".styled(with: Const.titleStyle)
    return node
  }()

  // MARK: Private

  private struct Const {
    static let shareButtonSize = CGSize(width: 22, height: 22)
    static let cacelButtonSize = CGSize(width: 17, height: 17)
    static let buttonTintColor = UIColor.black
    static let contentPadding = UIEdgeInsets(top: 12, left: 12, bottom: 9, right: 12)
    static let titleStyle = StringStyle(.font(.systemFont(ofSize: 14, weight: .semibold)), .color(.black))
    static let normalStateOfButtonTitleStyle = StringStyle(.font(.systemFont(ofSize: 13, weight: .bold)), .color(.black))
    static let disabledStateOfButtonTitleStyle = StringStyle(.font(.systemFont(ofSize: 13, weight: .bold)), .color(#colorLiteral(red: 0.5882352941, green: 0.5882352941, blue: 0.5882352941, alpha: 1)))
  }
}

// MARK: - LayoutSpec

extension PostHeaderNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentLayout = ASStackLayoutSpec(
      direction: .horizontal,
      spacing: .zero,
      justifyContent: .spaceBetween,
      alignItems: .center,
      children: [
        cancelButton,
        titleNode,
        shareButton,
      ])

    return ASInsetLayoutSpec(insets: Const.contentPadding, child: contentLayout)
  }
}
