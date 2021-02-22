import AsyncDisplayKit
import BonMot

// MARK: - SearchUserCellNode

final class SearchUserCellNode: ASCellNode {

  // MARK: Lifecycle

  init(item: SearchDisplayModel.SearchContentSectionItem.Item) {
    self.item = item
    super.init()
    automaticallyManagesSubnodes = true
  }

  deinit {
    print("SearchUserCellNode deinit...")
  }

  // MARK: Internal

  let item: SearchDisplayModel.SearchContentSectionItem.Item

  // MARK: Private

  private struct Const {
    static var photoNodeSize = CGSize(width: 45, height: 45)
    static var userNameStingStyle = StringStyle(.font(.systemFont(ofSize: 15, weight: .semibold)), .color(.black))
    static var descriptionStringStyle = StringStyle(.font(.systemFont(ofSize: 13)), .color(#colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)))
    static var contentSpacing: CGFloat = 9
    static var contentPadding = UIEdgeInsets(top: 12.5, left: 12, bottom: 11, right: 12)
  }

  private lazy var photoNodes: ASNetworkImageNode = {
    let node = ASNetworkImageNode()
    node.defaultImage = #imageLiteral(resourceName: "dummy-content-image")
    node.placeholderEnabled = true
    node.url = URL(string: item.avatarImageURL)
    node.contentMode = .scaleAspectFill
    node.style.preferredSize = Const.photoNodeSize
    node.cornerRadius = Const.photoNodeSize.width / 2
    return node
  }()

  private lazy var userNameNode: ASTextNode = {
    let node = ASTextNode()
    node.maximumNumberOfLines = 1
    node.attributedText = item.userName.styled(with: Const.userNameStingStyle)
    return node
  }()

  private lazy var descriptionNode: ASTextNode = {
    let node = ASTextNode()
    node.maximumNumberOfLines = 0
    node.attributedText = item.fullName.styled(with: Const.descriptionStringStyle)
    return node
  }()

}

// MARK: - LayoutSpec

extension SearchUserCellNode {

  // MARK: Internal

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    ASInsetLayoutSpec(
      insets: Const.contentPadding,
      child: contentsAreaLayoutSpec())
  }

  // MARK: Private

  private func textAreaLayoutSpec() -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .vertical,
      spacing: .zero,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        userNameNode,
        descriptionNode,
      ])
  }

  private func contentsAreaLayoutSpec() -> ASLayoutSpec {
    let aaa = ASLayoutSpec()
    aaa.style.flexGrow = 1

    let contentLayout = ASStackLayoutSpec(
      direction: .horizontal,
      spacing: Const.contentSpacing,
      justifyContent: .start,
      alignItems: .center,
      children: [
        photoNodes,
        textAreaLayoutSpec(),
        aaa,
      ])

    contentLayout.style.width = .init(unit: .fraction, value: 1.0)

    return contentLayout
  }
}
