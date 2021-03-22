import AsyncDisplayKit
import BonMot
import RxSwift

// MARK: - CommentHeaderNode

final class CommentHeaderNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    super.init()

    automaticallyManagesSubnodes = true
    automaticallyRelayoutOnSafeAreaChanges = true
    backgroundColor = .white
  }

  deinit {
    print("CommentHeaderNode deinit...")
  }

  // MARK: Private

  private struct Const {
    static var buttonSize = CGSize(width: 24, height: 24)
    static var butrtonTintColor = UIColor.black
    static var titleStyle = StringStyle(.font(.systemFont(ofSize: 13, weight: .bold)), .color(.black))
    static let contentPadding = UIEdgeInsets(top: 12.5, left: 12, bottom: 12, right: 12)
  }

  private let titleNode: ASTextNode = {
    let node = ASTextNode()
    node.maximumNumberOfLines = 1
    node.attributedText = "Comment".styled(with: Const.titleStyle)
    node.isLayerBacked = true
    return node
  }()

  private let backButtonNode: ASButtonNode = {
    let node = ASButtonNode()
    node.style.preferredSize = Const.buttonSize
    node.setImage(#imageLiteral(resourceName: "back-icon"), for: .normal)
    node.tintColor = Const.butrtonTintColor
    return node
  }()

}

// MARK: - LayoutSpec

extension CommentHeaderNode {

  // MARK: Internal

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: .zero,
      justifyContent: .start,
      alignItems: .stretch,
      children: [ contentAreaLayoutSpec() ])

    return ASInsetLayoutSpec(insets: Const.contentPadding, child: contentLayout)
  }

  // MARK: Private

  private func contentAreaLayoutSpec() -> ASLayoutSpec {
    let flexibleSpacer = ASLayoutSpec()
    flexibleSpacer.style.width = backButtonNode.style.width

    return ASStackLayoutSpec(
      direction: .horizontal,
      spacing: .zero,
      justifyContent: .spaceBetween,
      alignItems: .center,
      children: [
        backButtonNode,
        titleNode,
        flexibleSpacer,
      ])
  }
}
