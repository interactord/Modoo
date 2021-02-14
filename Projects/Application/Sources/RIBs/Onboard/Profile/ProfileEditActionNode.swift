import AsyncDisplayKit
import BonMot

// MARK: - ProfileEditActionNode

final class ProfileEditActionNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    super.init()
    automaticallyManagesSubnodes = true
  }

  // MARK: Internal

  let editProfileButton: ASButtonNode = {
    let node = ASButtonNode()
    node.cornerRadius = Const.buttonCornerRadius
    node.borderWidth = Const.buttonBorderWidth
    node.borderColor = Const.buttonBorderColor.cgColor
    node.style.height = Const.buttonHeight
    node.setAttributedTitle("Edit Profile".styled(with: Const.buttonTitleStyle), for: .normal)
    return node
  }()

  // MARK: Private

  private struct Const {
    static let buttonTitleStyle = StringStyle(.font(.systemFont(ofSize: 13)), .color(.black))
    static let buttonHeight = ASDimension(unit: .points, value: 26)
    static let buttonCornerRadius: CGFloat = 2
    static let buttonBorderWidth: CGFloat = 1
    static let buttonBorderColor = #colorLiteral(red: 0.8549019608, green: 0.8588235294, blue: 0.8549019608, alpha: 1)
    static let contentPadding = UIEdgeInsets(top: 9, left: 0, bottom: 9, right: 0)
  }
}

// MARK: - LayoutSpec

extension ProfileEditActionNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    ASInsetLayoutSpec(insets: Const.contentPadding, child: editProfileButton)
  }
}
