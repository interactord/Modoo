import AsyncDisplayKit
import BonMot

// MARK: - FeedPostDescriptionNode

final class FeedPostDescriptionNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    super.init()
    automaticallyManagesSubnodes = true
  }

  deinit {
    print("FeedPostDescriptionNode deinit...")
  }

  // MARK: Internal

  let descriptionNode: ASTextNode = {
    let dummyText = "Lorem Ipsum is simply dummy text of the printing and ..."
    let node = ASTextNode()
    node.maximumNumberOfLines = .zero
    node.attributedText = dummyText.styled(with: Const.descriptionTextStyle)
    return node
  }()

  let likeInformationNode: ASTextNode = {
    let dummyText = "1 like"
    let node = ASTextNode()
    node.maximumNumberOfLines = 1
    node.attributedText = dummyText.styled(with: Const.descriptionTextStyle)
    return node
  }()

  // MARK: Private

  private struct Const {
    static let descriptionTextStyle = StringStyle(.font(.systemFont(ofSize: 12)), .color(.black))
    static let contentsLayout = UIEdgeInsets(top: 2, left: 12, bottom: 12, right: 10)
  }
}

// MARK: - layoutSpec

extension FeedPostDescriptionNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: .zero,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        likeInformationNode,
        descriptionNode,
      ])
    return ASInsetLayoutSpec(
      insets: Const.contentsLayout,
      child: contentLayout)
  }

}
