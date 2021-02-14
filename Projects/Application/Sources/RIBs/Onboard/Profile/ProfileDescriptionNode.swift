import AsyncDisplayKit
import BonMot

// MARK: - ProfileDescriptionNode

final class ProfileDescriptionNode: ASDisplayNode {

  // MARK: Lifecycle

  init(descriptionString: String) {
    self.descriptionString = descriptionString
    super.init()
    automaticallyManagesSubnodes = true
  }

  // MARK: Internal

  lazy var descipritionNode: ASTextNode = {
    let node = ASTextNode()
    node.maximumNumberOfLines = .zero
    node.attributedText = descriptionString.styled(with: Const.descrtionStyle)
    node.isLayerBacked = true
    return node
  }()

  let descriptionString: String

  // MARK: Private

  private struct Const {
    static let descrtionStyle = StringStyle(.font(.systemFont(ofSize: 13)), .color(.black))
    static let contentPadding = UIEdgeInsets(top: 9, left: 0, bottom: 9, right: 0)
  }

}

// MARK: - LayoutSpec

extension ProfileDescriptionNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    ASInsetLayoutSpec(insets: Const.contentPadding, child: descipritionNode)
  }
}
