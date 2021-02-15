import AsyncDisplayKit

// MARK: - ProfileMediaContentActionNode

final class ProfileMediaContentActionNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    super.init()
    automaticallyManagesSubnodes = true
  }

  // MARK: Internal

  let thumbnailButton: ASButtonNode = {
    let node = ASButtonNode()
    node.setImage(#imageLiteral(resourceName: "thumb-icon"), for: .normal)
    node.tintColor = Const.normalStateButtonTintColor
    node.style.height = Const.buttonHeight
    node.style.flexGrow = 1
    return node
  }()

  let listButton: ASButtonNode = {
    let node = ASButtonNode()
    node.setImage(#imageLiteral(resourceName: "list-icon"), for: .normal)
    node.tintColor = Const.normalStateButtonTintColor
    node.style.height = Const.buttonHeight
    node.style.flexGrow = 1
    return node
  }()

  let bookmarkButton: ASButtonNode = {
    let node = ASButtonNode()
    node.setImage(#imageLiteral(resourceName: "bookmark-icon"), for: .normal)
    node.tintColor = Const.normalStateButtonTintColor
    node.style.height = Const.buttonHeight
    node.style.flexGrow = 1
    return node
  }()

  // MARK: Private

  private struct Const {
    static var buttonHeight = ASDimension(unit: .points, value: 50)
    static var activeLineColor = UIColor.black
    static var actionLineHeight = ASDimension(unit: .points, value: 2.0)
    static var selectedStateButtonTintColor = UIColor.black
    static var normalStateButtonTintColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
  }

  private let activeLineNode: ASDisplayNode = {
    let node = ASDisplayNode()
    node.isLayerBacked = true
    node.backgroundColor = Const.activeLineColor
    node.style.height = Const.actionLineHeight
    return node
  }()

}

// MARK: - LayoutSpec

extension ProfileMediaContentActionNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

    ASStackLayoutSpec(
      direction: .horizontal,
      spacing: .zero,
      justifyContent: .spaceAround,
      alignItems: .stretch,
      children: [
        thumbnailButton,
        listButton,
        bookmarkButton,
      ])
  }
}
