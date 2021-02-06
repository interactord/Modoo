import AsyncDisplayKit

// MARK: - RegisterContainerNode

final class RegisterContainerNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    super.init()
    automaticallyManagesSubnodes = true
    automaticallyRelayoutOnSafeAreaChanges = true
    backgroundColor = .systemPink
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    print("RegisterContainerNode deinit...")
  }

  // MARK: Internal

  private(set) lazy var plusButton: ASButtonNode = {
    let node = ASButtonNode()
    node.setImage(#imageLiteral(resourceName: "register-photo"), for: .normal)
    node.tintColor = Const.plusButtonTintColor
    node.style.preferredSize = Const.plusButtonSize
    return node
  }()

  private(set) lazy var emailInputNode: FormInputNode = {
    let node = FormInputNode(placeholderText: "Email", keyboardType: .emailAddress)
    node.style.preferredLayoutSize = Const.formElementPreferredLayoutSize
    return node
  }()

  private(set) lazy var passwordInputNode: FormInputNode = {
    let node = FormInputNode(placeholderText: "Password", isSecureTextEntry: false)
    node.style.preferredLayoutSize = Const.formElementPreferredLayoutSize
    return node
  }()

  private(set) lazy var fullNameInputNode: FormInputNode = {
    let node = FormInputNode(placeholderText: "Fullname", keyboardType: .default)
    node.style.preferredLayoutSize = Const.formElementPreferredLayoutSize
    return node
  }()

  private(set) lazy var usernameInputNode: FormInputNode = {
    let node = FormInputNode(placeholderText: "Username", keyboardType: .default)
    node.style.preferredLayoutSize = Const.formElementPreferredLayoutSize
    return node
  }()

  private(set) lazy var signUpButton: FormPrimaryButtonNode = {
    let node = FormPrimaryButtonNode(type: .signUp)
    node.style.preferredLayoutSize = Const.formElementPreferredLayoutSize
    return node
  }()

  let alreadyHaveAccountButton = FormSecondaryButtonNode(type: .signUp)

  override func layoutDidFinish() {
    super.layoutDidFinish()
    backgroundNode
      .gradientBackgroundColor(
        colors:
        [
          Const.gradientStartColor,
          Const.gradientEndColor,
        ],
        direction: .vertical)
  }

  // MARK: Private

  private struct Const {
    static let gradientStartColor = UIColor.systemPurple.cgColor
    static let gradientEndColor = UIColor.systemBlue.cgColor
    static let plusButtonTintColor = UIColor.white
    static let layoutContentPadding = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    static let plusButtonSize = CGSize(width: 140, height: 140)
    static let formElementPreferredLayoutSize = ASLayoutSize(
      width: .init(unit: .fraction, value: 1),
      height: .init(unit: .points, value: 50))
  }

  private var backgroundNode = ASDisplayNode()

}

// MARK: - LayoutSpec

extension RegisterContainerNode {

  // MARK: Internal

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: .zero,
      justifyContent: .spaceBetween,
      alignItems: .center,
      children: [
        headerContentLayoutSpec(),
        alreadyHaveAccountButton,
      ])

    let contentLayoutWithPadding = ASInsetLayoutSpec(
      insets: .merge(list: [Const.layoutContentPadding, safeAreaInsets]),
      child: contentLayout)

    return ASBackgroundLayoutSpec(child: contentLayoutWithPadding, background: backgroundNode)
  }

  // MARK: Private

  private func headerContentLayoutSpec() -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .vertical,
      spacing: 32,
      justifyContent: .start,
      alignItems: .center,
      children: [
        plusButton, formGroupLayoutSpec(),
      ])
  }

  private func formGroupLayoutSpec() -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .vertical,
      spacing: 20,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        emailInputNode,
        passwordInputNode,
        fullNameInputNode,
        usernameInputNode,
        signUpButton,
      ])
  }
}
