import AsyncDisplayKit
import RxSwift

// MARK: - SubProfileInformationCellNode

final class SubProfileInformationCellNode: ASCellNode {

  // MARK: Lifecycle

  init(item: UserInformationSectionModel.Header) {
    self.item = item
    super.init()
    automaticallyManagesSubnodes = true
    backgroundColor = .white
  }

  // MARK: Internal

  let disposeBag = DisposeBag()

  lazy var summeryNode: ProfileInformationSummeryNode = {
    ProfileInformationSummeryNode(
      imageURL: item.avatarImageURL,
      postCount: "\(item.postCount)",
      followerCount: "\(item.followerCount)",
      followingCount: "\(item.followingCount)")
  }()

  lazy var actionNode: ProfileSocialActionNode = {
    ProfileSocialActionNode(isFollowed: item.isFollowed)
  }()

  // MARK: Private

  private struct Const {
    static let contentPadding = UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12)
  }

  private let item: UserInformationSectionModel.Header

}

// MARK: - LayoutSpec

extension SubProfileInformationCellNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: .zero,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        summeryNode,
        actionNode,
      ])

    return ASInsetLayoutSpec(insets: Const.contentPadding, child: contentLayout)
  }
}

// MARK: - Stream

extension SubProfileInformationCellNode {
  var followButtonTapStream: Observable<Void> {
    actionNode.followButton.rx.tap.asObservable()
  }

  var unFollowButtonTapStream: Observable<Void> {
    actionNode.unFollowButton.rx.tap.asObservable()
  }

  var messageButtonTapStream: Observable<Void> {
    actionNode.messageButton.rx.tap.asObservable()
  }
}
