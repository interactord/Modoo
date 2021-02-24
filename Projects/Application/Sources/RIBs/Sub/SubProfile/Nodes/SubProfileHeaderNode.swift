import AsyncDisplayKit
import BonMot
import RxSwift

// MARK: - SubProfileHeaderNode

final class SubProfileHeaderNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    super.init()
    automaticallyManagesSubnodes = true
    backgroundColor = .clear
  }

  deinit {
    print("SubProfileHeaderNode deinit...")
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

extension SubProfileHeaderNode {

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
    ASStackLayoutSpec(
      direction: .horizontal,
      spacing: .zero,
      justifyContent: .spaceBetween,
      alignItems: .center,
      children: [
        backButtonNode,
        titleNode,
        ASLayoutSpec(),
      ])
  }
}

// MARK: - Stream

extension SubProfileHeaderNode {
  var titleBinder: Binder<String> {
    Binder(self, scheduler: CurrentThreadScheduler.instance) { base, title in
      base.titleNode.attributedText = title.styled(with: Const.titleStyle)
    }
  }

  var backButtonTapStream: Observable<Void> {
    backButtonNode.rx.tap.asObservable()
  }
}
