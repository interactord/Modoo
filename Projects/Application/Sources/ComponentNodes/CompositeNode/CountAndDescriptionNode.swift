import AsyncDisplayKit
import BonMot

// MARK: - CountAndDescriptionNode

final class CountAndDescriptionNode: ASDisplayNode {

  // MARK: Lifecycle

  init(count: String, label: String) {
    self.count = count
    self.label = label
    super.init()
    automaticallyManagesSubnodes = true
    backgroundColor = .clear
  }

  deinit {
    print("VericalCountAndDescriptionNode deinit...")
  }

  // MARK: Internal

  lazy var countNode: ASTextNode = {
    let node = ASTextNode()
    node.maximumNumberOfLines = 1
    node.attributedText = count.styled(with: Const.countStyle)
    node.isLayerBacked = true
    return node
  }()

  lazy var descriptionNode: ASTextNode = {
    let node = ASTextNode()
    node.maximumNumberOfLines = 1
    node.attributedText = label.styled(with: Const.descriptionStyle)
    node.isLayerBacked = true
    return node
  }()

  lazy var buttonNode = ASButtonNode()

  // MARK: Private

  private struct Const {
    static let countStyle =
      StringStyle(
        .font(.systemFont(ofSize: 17.0, weight: .semibold)),
        .color(.black),
        .alignment(.center))
    static let descriptionStyle =
      StringStyle(
        .font(.systemFont(ofSize: 13.0)),
        .color(.black),
        .alignment(.center))
    static let spacing: CGFloat = 2.0
  }

  private let count: String
  private let label: String

}

// MARK: - LayoutSpec

extension CountAndDescriptionNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentsLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: Const.spacing,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        countNode,
        descriptionNode,
      ])

    return ASOverlayLayoutSpec(child: contentsLayout, overlay: buttonNode)
  }
}
