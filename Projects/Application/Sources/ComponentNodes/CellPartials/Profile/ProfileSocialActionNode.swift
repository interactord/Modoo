import AsyncDisplayKit
import BonMot
import RxSwift

// MARK: - ProfileSocialActionNode

final class ProfileSocialActionNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    super.init()
    automaticallyManagesSubnodes = true
  }

  // MARK: Internal

  let followButton: ASButtonNode = {
    let node = ASButtonNode()
    node.setAttributedTitle("Following".styled(with: Const.normalOfStateButtonTitleStyle), for: .normal)
    node.cornerRadius = Const.buttonCornerRadius
    node.borderWidth = Const.buttonBorderWidth
    node.borderColor = Const.normalOfStateButtonBorderColor.cgColor
    node.style.height = Const.buttonHeight
    node.style.flexGrow = 1
    return node
  }()

  let messageButton: ASButtonNode = {
    let node = ASButtonNode()
    node.setAttributedTitle("Message".styled(with: Const.normalOfStateButtonTitleStyle), for: .normal)
    node.cornerRadius = Const.buttonCornerRadius
    node.borderWidth = Const.buttonBorderWidth
    node.borderColor = Const.normalOfStateButtonBorderColor.cgColor
    node.style.height = Const.buttonHeight
    node.style.flexGrow = 1
    return node
  }()

  // MARK: Private

  private struct Const {
    static let normalOfStateButtonTitleStyle = StringStyle(.font(.systemFont(ofSize: 13)), .color(.black))
    static let buttonHeight = ASDimension(unit: .points, value: 26)
    static let buttonCornerRadius: CGFloat = 2
    static let buttonBorderWidth: CGFloat = 1
    static let normalOfStateButtonBorderColor = #colorLiteral(red: 0.8549019608, green: 0.8588235294, blue: 0.8549019608, alpha: 1)
    static let contentPadding = UIEdgeInsets(top: 9, left: 0, bottom: 9, right: 0)
    static let buttonGroupSpacing: CGFloat = 5.0
  }

}

// MARK - LayoutSpec

extension ProfileSocialActionNode {

  // MARK: Internal

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: .zero,
      justifyContent: .start,
      alignItems: .stretch,
      children: [buttonGroupAreaLayoutSpec()])

    return ASInsetLayoutSpec(insets: Const.contentPadding, child: contentLayout)
  }

  // MARK: Private

  private func buttonGroupAreaLayoutSpec() -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .horizontal,
      spacing: Const.buttonGroupSpacing,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        followButton,
        messageButton,
      ])
  }
}

// MARK - Stream

extension ProfileSocialActionNode {
}
