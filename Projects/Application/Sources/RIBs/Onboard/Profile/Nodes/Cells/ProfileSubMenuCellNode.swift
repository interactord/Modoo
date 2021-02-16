import AsyncDisplayKit

// MARK: - ProfileSubMenuCellNode

final class ProfileSubMenuCellNode: ASCellNode {

  // MARK: Lifecycle

  override init() {
    super.init()
    automaticallyManagesSubnodes = true
    backgroundColor = .white
  }

  deinit {
    print("ProfileSubMenuCellNode deinit...")
  }

  // MARK: Internal

  let contentActionNode = ProfileMediaContentActionNode()

  // MARK: Private

  private struct Const {
    static let contentPaddding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
  }

}

// MARK: - LayoutSpec

extension ProfileSubMenuCellNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    ASInsetLayoutSpec(insets: Const.contentPaddding, child: contentActionNode)
  }
}
