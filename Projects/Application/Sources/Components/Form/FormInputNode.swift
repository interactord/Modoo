import AsyncDisplayKit
import BonMot

// MARK: - FormInputNode

final class FormInputNode: ASDisplayNode {

  // MARK: Lifecycle

  init(placeholderText: String, isSecureTextEntry: Bool = false, keyboardType: UIKeyboardType = .default) {
    self.placeholderText = placeholderText
    self.isSecureTextEntry = isSecureTextEntry
    self.keyboardType = keyboardType

    super.init()

    automaticallyManagesSubnodes = true
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    print("FormInputNode deinit...")
  }

  // MARK: Internal

  struct Const {
    static let backgroundColor = UIColor.init(white: 1.0, alpha: 0.1)
    static let backgroundConnerRadius: CGFloat = 5.0
    static let placeholderTextStyle = StringStyle(.font(.systemFont(ofSize: 12)), .color(.init(white: 1, alpha: 0.7)))
    static let typingTextStyle = StringStyle(.font(.systemFont(ofSize: 12)), .color(.white))
    static let layoutContentPadding = UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
  }

  // MARK: Private

  private let placeholderText: String
  private let isSecureTextEntry: Bool
  private let keyboardType: UIKeyboardType
  private lazy var backgroundNode: ASDisplayNode = {
    let node = ASDisplayNode()
    node.backgroundColor = Const.backgroundColor
    node.cornerRadius = Const.backgroundConnerRadius
    return node
  }()
  private lazy var textFieldNode: TextFieldNode = {
    let node = TextFieldNode()
    node.attributedPlaceholder = placeholderText.styled(with: Const.placeholderTextStyle)
    node.defaultTextAttributes = Const.typingTextStyle.attributes
    node.isSecureTextEntry = isSecureTextEntry
    node.keyboardType = keyboardType
    node.keyboardAppearance = .dark
    return node
  }()
}

// MARK: - LayoutSpec

extension FormInputNode {
  public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentLayout = ASInsetLayoutSpec(
      insets: Const.layoutContentPadding,
      child: textFieldNode)
    return ASBackgroundLayoutSpec(child: contentLayout, background: backgroundNode)
  }
}
