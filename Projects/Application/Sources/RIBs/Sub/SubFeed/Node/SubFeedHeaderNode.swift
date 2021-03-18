import AsyncDisplayKit
import BonMot
import RxSwift

// MARK: - SubFeedHeaderNode

final class SubFeedHeaderNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    defer { automaticallyManagesSubnodes = true }
    super.init()
  }

  // MARK: Internal

  let backButtonNode: ASButtonNode = {
    let node = ASButtonNode()
    node.setImage(#imageLiteral(resourceName: "back-icon"), for: .normal)
    node.tintColor = Const.butrtonTintColor
    node.style.preferredSize = Const.buttonSize
    return node
  }()

  lazy var titleButtonNode: ASTextNode = {
    let node = ASTextNode()
    let titleElements = ["ASBGF123".styled(with: Const.subTitleStyle), "\n".styled(with: Const.subTitleStyle), "Feed".styled(with: Const.titleStyle)]
    node.attributedText = NSAttributedString.composed(of: titleElements)
    node.maximumNumberOfLines = 2
    node.isLayerBacked = true
    return node
  }()

  // MARK: Private

  private struct Const {
    static var buttonSize = CGSize(width: 24, height: 24)
    static var butrtonTintColor = UIColor.black
    static var titleStyle = StringStyle(.font(.systemFont(ofSize: 13, weight: .bold)), .color(.black), .alignment(.center))
    static var subTitleStyle = StringStyle(.font(.systemFont(ofSize: 10, weight: .bold)), .color(#colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)), .alignment(.center))
    static let contentPadding = UIEdgeInsets(top: 12.5, left: 12, bottom: 12, right: 12)
  }

}

// MARK: - LayoutSpec

extension SubFeedHeaderNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let flexibleSpacer = ASLayoutSpec()
    flexibleSpacer.style.preferredSize = Const.buttonSize

    let contentLayout = ASStackLayoutSpec(
      direction: .horizontal,
      spacing: .zero,
      justifyContent: .spaceBetween,
      alignItems: .start,
      children: [
        backButtonNode,
        titleButtonNode,
        flexibleSpacer,
      ])

    return ASInsetLayoutSpec(
      insets: Const.contentPadding,
      child: contentLayout)
  }
}

// MARK: - Stream

extension SubFeedHeaderNode {
  var backButtonTabStream: Observable<Void> {
    backButtonNode.rx.tap.asObservable()
  }
}
