import AsyncDisplayKit

// MARK: - ProfileInformationCellNode

final class ProfileInformationCellNode: ASCellNode {

  // MARK: Lifecycle

  init(item: ProfileInformationSectionItemModel) {
    self.item = item
    super.init()
    automaticallyManagesSubnodes = true
    backgroundColor = .white
  }

  deinit {
    print("ProfileInformationCell deinit...")
  }

  // MARK: Internal

  let item: ProfileInformationSectionItemModel

  lazy var summeryNode: ProfileInformationSummeryNode = {
    ProfileInformationSummeryNode(
      imageURL: item.avatarImageURL,
      postCount: "\(item.postCount)",
      followerCount: "\(item.followerCount)",
      followingCount: "\(item.followingCount)")
  }()

  lazy var descriptionNode: ProfileDescriptionNode = {
    ProfileDescriptionNode(descriptionString: item.bioDescription)
  }()

  let profileEditActionNode = ProfileEditActionNode()

  // MARK: Private

  private struct Const {
    static let contentPadding = UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12)
  }
}

// MARK: - LayoutSpec

extension ProfileInformationCellNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    style.width = .init(unit: .fraction, value: 1.0)

    let contentLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: .zero,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        summeryNode,
        descriptionNode,
        profileEditActionNode,
      ])

    return ASInsetLayoutSpec(insets: Const.contentPadding, child: contentLayout)
  }
}
