import AsyncDisplayKit
import BonMot

// MARK: - ProfileInformationSummeryNode

final class ProfileInformationSummeryNode: ASDisplayNode {

  // MARK: Lifecycle

  init(imageURL: String, postCount: String, followerCount: String, followingCount: String) {
    self.imageURL = imageURL
    self.postCount = postCount
    self.followerCount = followerCount
    self.followingCount = followingCount
    super.init()
    automaticallyManagesSubnodes = true
    backgroundColor = .clear
  }

  deinit {
    print("ProfileInformationSummeryNode deinit...")
  }

  // MARK: Internal

  lazy var profileImageNode: ASNetworkImageNode = {
    let node = ASNetworkImageNode()
    node.defaultImage = #imageLiteral(resourceName: "dummy-content-image")
    node.placeholderEnabled = true
    node.url = URL(string: imageURL)
    node.cornerRadius = Const.imageSize.width / 2
    node.style.preferredSize = Const.imageSize
    node.isLayerBacked = true
    return node
  }()

  lazy var postsNode: CountAndDescriptionNode = {
    CountAndDescriptionNode(count: postCount, label: "Posts")
  }()

  lazy var followerNode: CountAndDescriptionNode = {
    CountAndDescriptionNode(count: followerCount, label: "Followers")
  }()

  lazy var followingNode: CountAndDescriptionNode = {
    CountAndDescriptionNode(count: followingCount, label: "Following")
  }()

  let postCount: String
  let followerCount: String
  let followingCount: String
  let imageURL: String

  // MARK: Private

  private struct Const {
    static let imageSize = CGSize(width: 79, height: 79)
    static let buttonGroupSpacing: CGFloat = 18
    static let contentSpacing: CGFloat = 30
    static let contentPadding = UIEdgeInsets(top: 0, left: 0, bottom: 9, right: 33)
  }

}

// MARK: - LayoutSpec

extension ProfileInformationSummeryNode {

  // MARK: Internal

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentLayout = ASStackLayoutSpec(
      direction: .horizontal,
      spacing: Const.contentSpacing,
      justifyContent: .start,
      alignItems: .center,
      children: [
        profileImageNode,
        buttonGroupAreaLayout(),
      ])

    return ASInsetLayoutSpec(insets: Const.contentPadding, child: contentLayout)
  }

  // MARK: Private

  private func buttonGroupAreaLayout() -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .horizontal,
      spacing: Const.buttonGroupSpacing,
      justifyContent: .spaceBetween,
      alignItems: .start,
      children: [
        postsNode,
        followerNode,
        followingNode,
      ])
  }
}
