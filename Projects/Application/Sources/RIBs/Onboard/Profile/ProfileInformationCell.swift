import AsyncDisplayKit
import BonMot

// MARK: - ProfileInformationCell

final class ProfileInformationCell: ASCellNode {

  // MARK: Lifecycle

  override init() {
    super.init()
    automaticallyManagesSubnodes = true
    backgroundColor = .white
  }

  deinit {
    print("ProfileInformationCell deinit...")
  }

  // MARK: Internal

  let summeryNode: ProfileInformationSummeryNode = {
    ProfileInformationSummeryNode(
      postCount: "213",
      followerCount: "863",
      followingCount: "408")
  }()

  let descriptionNode: ProfileDescriptionNode = {
    ProfileDescriptionNode(descriptionString: "Antoninagarcia")
  }()

  let profileEditActionNode = ProfileEditActionNode()
  let mediaContentActionNode = ProfileMediaContentActionNode()

  // MARK: Private

  private struct Const {
    static let contentPadding = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
  }
}

// MARK: - LayoutSpec

extension ProfileInformationCell {
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
        mediaContentActionNode,
      ])

    return ASInsetLayoutSpec(insets: Const.contentPadding, child: contentLayout)
  }
}
