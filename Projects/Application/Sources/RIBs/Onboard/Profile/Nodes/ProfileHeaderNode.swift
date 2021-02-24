import AsyncDisplayKit
import BonMot
import Foundation
import RxSwift

// MARK: - ProfileHeaderNode

final class ProfileHeaderNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    super.init()
    automaticallyManagesSubnodes = true
    backgroundColor = .clear
  }

  deinit {
    print("ProfileHeaderNode deinit...")
  }

  // MARK: Internal

  let titleNode: ASTextNode = {
    let node = ASTextNode()
    node.attributedText = "".styled(with: Const.titleStyle)
    node.isLayerBacked = true
    return node
  }()

  let moreButton: ASButtonNode = {
    let node = ASButtonNode()
    node.style.preferredSize = Const.buttonSize
    node.setImage(#imageLiteral(resourceName: "more-normal"), for: .normal)
    node.tintColor = .black
    return node
  }()

  var title = "" {
    didSet {
      titleNode.attributedText = title.styled(with: Const.titleStyle)
    }
  }

  // MARK: Private

  private struct Const {
    static let buttonSize = CGSize(width: 24, height: 24)
    static let titleStyle = StringStyle(.font(.systemFont(ofSize: 13, weight: .bold)), .color(.black))
    static let contentsPadding = UIEdgeInsets(top: 12.5, left: 12, bottom: 12, right: 12)
  }
}

// MARK: - LayoutSpec

extension ProfileHeaderNode {

  // MARK: Internal

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentLayout = ASStackLayoutSpec(
      direction: .horizontal,
      spacing: .zero,
      justifyContent: .spaceBetween,
      alignItems: .stretch,
      children: [
        leftAreaLayoutSpec(),
        rightAreaLayoutSpec(),
      ])

    return ASInsetLayoutSpec(insets: Const.contentsPadding, child: contentLayout)
  }

  // MARK: Private

  private func leftAreaLayoutSpec() -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .horizontal,
      spacing: .zero,
      justifyContent: .start,
      alignItems: .start,
      children: [
        titleNode,
      ])
  }

  private func rightAreaLayoutSpec() -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .horizontal,
      spacing: .zero,
      justifyContent: .end,
      alignItems: .center,
      children: [
        moreButton,
      ])
  }
}
