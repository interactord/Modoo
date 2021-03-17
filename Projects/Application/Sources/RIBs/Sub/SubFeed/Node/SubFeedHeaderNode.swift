import AsyncDisplayKit
import BonMot

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
    node.setImage(#imageLiteral(resourceName: "yp_arrow_left"), for: .normal)
    node.tintColor = Const.butrtonTintColor
    node.style.preferredSize = Const.buttonSize
    return node
  }()

  // MARK: Private

  private struct Const {
    static var buttonSize = CGSize(width: 24, height: 24)
    static var butrtonTintColor = UIColor.black
    static var titleStyle = StringStyle(.font(.systemFont(ofSize: 13, weight: .bold)), .color(.black))
    static var subTitleStyle = StringStyle(.font(.systemFont(ofSize: 10, weight: .bold)), .color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
    static let contentPadding = UIEdgeInsets(top: 12.5, left: 12, bottom: 12, right: 12)
  }

}

// MARK: - LayoutSpec

extension SubFeedHeaderNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    ASLayoutSpec()
  }
}
