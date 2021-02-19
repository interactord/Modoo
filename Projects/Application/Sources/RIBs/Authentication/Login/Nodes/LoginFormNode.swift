import AsyncDisplayKit

// MARK: - LoginFormNode

final class LoginFormNode: ASScrollNode {

  // MARK: Lifecycle

  init(
    emailInputNode: TextInputNodeViewable = FormTextInputNode(scope: .email),
    passwordInputNode: TextInputNodeViewable = FormTextInputNode(scope: .password))
  {
    self.emailInputNode = emailInputNode
    self.passwordInputNode = passwordInputNode
    super.init()
    automaticallyManagesContentSize = true
    automaticallyManagesSubnodes = true
    backgroundColor = .clear
  }

  deinit {
    print("LoginFormNode deinit...")
  }

  // MARK: Internal

  let logoNode: ASImageNode = {
    let node = ASImageNode()
    node.image = #imageLiteral(resourceName: "instargram-logo")
    node.tintColor = Const.logoTintColor
    node.contentMode = .scaleAspectFit
    node.style.preferredSize = Const.logoSize
    node.isLayerBacked = true
    return node
  }()

  let emailInputNode: TextInputNodeViewable
  let passwordInputNode: TextInputNodeViewable
  let loginButtonNode = FormPrimaryButtonNode(type: .login)
  let forgetPasswordButton = FormSecondaryButtonNode(type: .helpSignIn)
  let keyboardDismissEventNode = ASControlNode()

  // MARK: Private

  private struct Const {
    static let logoTintColor = UIColor.white
    static let logoSize = CGSize(width: 220, height: 80)
    static let inputFieldSpacing: CGFloat = 20.0
    static let logoPadding =
      UIEdgeInsets(top: 0.0, left: 0, bottom: 24, right: 0)
  }

}

extension LoginFormNode {

  // MARK: Internal

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: 14.0,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        logoAreaLayoutSpec(),
        inputFieldAreaLayoutSpec(),
      ])

    return ASOverlayLayoutSpec(
      child: keyboardDismissEventNode,
      overlay: contentLayout)
  }

  // MARK: Private

  private func inputFieldAreaLayoutSpec() -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .vertical,
      spacing: Const.inputFieldSpacing,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        emailInputNode.node,
        passwordInputNode.node,
        loginButtonNode,
        forgetPasswordButton,
      ])
  }

  private func logoAreaLayoutSpec() -> ASLayoutSpec {
    let stackLayout = ASStackLayoutSpec(
      direction: .horizontal,
      spacing: .zero,
      justifyContent: .center,
      alignItems: .stretch,
      children: [logoNode])

    return ASInsetLayoutSpec(
      insets: Const.logoPadding,
      child: stackLayout)
  }
}
