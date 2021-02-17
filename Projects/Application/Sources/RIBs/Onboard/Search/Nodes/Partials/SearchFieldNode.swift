import AsyncDisplayKit
import BonMot
import RxCocoa
import UIKit

// MARK: - SearchFieldNode

final class SearchFieldNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    super.init()
    automaticallyManagesSubnodes = true

    backgroundColor = Const.backgroundColor
    cornerRadius = Const.backgroundCorrerRadius
  }

  deinit {
    print("TextFieldNode deinit...")
  }

  // MARK: Internal

  var textView: UITextField? {
    textFieldNode.view as? UITextField
  }

  override func didLoad() {
    super.didLoad()

    textView?.returnKeyType = .search
    textView?.clearButtonMode = .whileEditing
    textView?.typingAttributes = Const.typingTextStyle.attributes
    textView?.attributedPlaceholder = "Search".styled(with: Const.placeholderTextStyle)
  }

  // MARK: Private

  private struct Const {
    static let contentHeight = ASDimension(unit: .points, value: 30.0)
    static let contentPadding = UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8)
    static let textFieldHeight = ASDimension(unit: .points, value: 18.0)
    static let backgroundCorrerRadius: CGFloat = 8.0
    static let placeholderTextStyle =
      StringStyle(.font(.systemFont(ofSize: 15)), .color(#colorLiteral(red: 0.5882352941, green: 0.5882352941, blue: 0.5882352941, alpha: 1)))
    static let typingTextStyle =
      StringStyle(.font(.systemFont(ofSize: 15)), .color(.black))
    static let backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
    static let iconSize = CGSize(width: 13, height: 13)
    static let iconTintColor = #colorLiteral(red: 0.5882352941, green: 0.5882352941, blue: 0.5882352941, alpha: 1)
    static let contentSpacing: CGFloat = 11.0
  }

  private let iconImageNode: ASImageNode = {
    let node = ASImageNode()
    node.image = #imageLiteral(resourceName: "search-select")
    node.tintColor = Const.iconTintColor
    node.isLayerBacked = true
    node.style.preferredSize = Const.iconSize
    return node
  }()

  private let textFieldNode: ASDisplayNode = {
    let node = ASDisplayNode(viewBlock: { UITextField() })
    node.style.height = Const.textFieldHeight
    node.style.flexGrow = 1
    return node
  }()

}

// MARK: - LayoutSpec

extension SearchFieldNode {

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let flexibleSpcingLayout = ASLayoutSpec()
    flexibleSpcingLayout.style.flexGrow = 1

    let contentLayout = ASStackLayoutSpec(
      direction: .horizontal,
      spacing: Const.contentSpacing,
      justifyContent: .start,
      alignItems: .center,
      children: [
        iconImageNode,
        textFieldNode,
      ])

    return ASInsetLayoutSpec(
      insets: Const.contentPadding,
      child: contentLayout)
  }

}
