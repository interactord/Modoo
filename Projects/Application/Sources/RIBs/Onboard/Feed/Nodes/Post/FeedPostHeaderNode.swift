import AsyncDisplayKit
import BonMot

// MARK: - FeedPostHeaderNode

final class FeedPostHeaderNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    super.init()
    automaticallyManagesSubnodes = true
  }

  deinit {
    print("FeedPostHeaderNode deinit...")
  }

  // MARK: Internal

  let profileImageNode: ASImageNode = {
    let node = ASImageNode()
    node.style.preferredSize = Const.buttonSize
    node.cornerRadius = Const.buttonSize.width / 2
    node.image = #imageLiteral(resourceName: "dummy-content-image")
    node.contentMode = .scaleAspectFill
    node.isLayerBacked = true
    return node
  }()

  let profileNameNode: ASButtonNode = {
    let node = ASButtonNode()
    node.setAttributedTitle(
      "profileNameNode".styled(
        with: Const.profileNameStyle),
      for: .normal)
    return  node
  }()

  let moreButtonNode: ASButtonNode = {
    let node = ASButtonNode()
    node.style.preferredSize = Const.buttonSize
    node.setImage(#imageLiteral(resourceName: "more-normal"), for: .normal)
    node.tintColor = .black
    return node
  }()

  // MARK: Private

  private struct Const {
    static let buttonSize = CGSize(width: 34.0, height: 34.0)
    static let profileNameStyle = StringStyle(.font(.systemFont(ofSize: 12, weight: .bold)), .color(.black))
    static let leftAreaLayoutSpacing: CGFloat = 9.0
    static let profileAreaLayoutSpacing: CGFloat = 9.0
    static let contentsPadding = UIEdgeInsets(top: 12.5, left: 12, bottom: 12, right: 12)
  }
}

// MARK: - LayoutSpec

extension FeedPostHeaderNode {

  // MARK: Internal

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentLayout = ASStackLayoutSpec(
      direction: .horizontal,
      spacing: .zero,
      justifyContent: .spaceBetween,
      alignItems: .center, children: [
        leftGroupAreaLayoutSpec(),
        moreButtonNode,
      ])

    return ASInsetLayoutSpec(
      insets: Const.contentsPadding,
      child: contentLayout)
  }

  // MARK: Private

  private func leftGroupAreaLayoutSpec() -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .horizontal,
      spacing: Const.leftAreaLayoutSpacing,
      justifyContent: .start,
      alignItems: .center,
      children: [
        profileImageNode, profileGroupLayoutSpec(),
      ])
  }

  private func profileGroupLayoutSpec() -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .vertical,
      spacing: Const.profileAreaLayoutSpacing,
      justifyContent: .start,
      alignItems: .start,
      children: [profileNameNode])
  }

}
