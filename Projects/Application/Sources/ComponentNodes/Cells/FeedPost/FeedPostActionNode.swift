import AsyncDisplayKit
import RxSwift

// MARK: - FeedActionNode

final class FeedActionNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    super.init()
    automaticallyManagesSubnodes = true
    backgroundColor = .clear
  }

  deinit {
    print("FeedActionNode deinit...")
  }

  // MARK: Internal

  let likeButtonNode: ASButtonNode = {
    let node = ASButtonNode()
    node.setImage(#imageLiteral(resourceName: "like-normal"), for: .normal)
    node.setImage(#imageLiteral(resourceName: "like-select"), for: .selected)
    node.style.preferredSize = Const.buttonSize
    node.tintColor = .black
    return node
  }()

  let commentButtonNode: ASButtonNode = {
    let node = ASButtonNode()
    node.setImage(#imageLiteral(resourceName: "reply-normal"), for: .normal)
    node.style.preferredSize = Const.buttonSize
    node.tintColor = .black
    return node
  }()

  let shareButtonNode: ASButtonNode = {
    let node = ASButtonNode()
    node.setImage(#imageLiteral(resourceName: "share-normal"), for: .normal)
    node.style.preferredSize = Const.buttonSize
    node.tintColor = .black
    return node
  }()

  let bookmarkButtonNode: ASButtonNode = {
    let node = ASButtonNode()
    node.setImage(#imageLiteral(resourceName: "bookmark-normal"), for: .normal)
    node.setImage(#imageLiteral(resourceName: "bookmark-select"), for: .selected)
    node.style.preferredSize = Const.buttonSize
    node.tintColor = .black
    return node
  }()

  // MARK: Private

  private struct Const {
    static let buttonSize = CGSize(width: 26.0, height: 26.0)
    static let buttonSpacing: CGFloat = 18.0
    static let contentsPadding = UIEdgeInsets(top: 6, left: 14, bottom: 8, right: 12)
  }
}

// MARK: - LayoutSpec

extension FeedActionNode {

  // MARK: Internal

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentsLayout = ASStackLayoutSpec(
      direction: .horizontal,
      spacing: .zero,
      justifyContent: .spaceBetween,
      alignItems: .stretch,
      children: [
        leftAreaLayoutSpec(),
        bookmarkButtonNode,
      ])

    return ASInsetLayoutSpec(insets: Const.contentsPadding, child: contentsLayout)
  }

  // MARK: Private

  private func leftAreaLayoutSpec() -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .horizontal,
      spacing: Const.buttonSpacing,
      justifyContent: .start,
      alignItems: .center,
      children: [
        likeButtonNode,
        commentButtonNode,
        shareButtonNode,
      ])
  }
}

// MARK: - Stream

extension FeedActionNode {
  var commentTabStream: Observable<Void> {
    commentButtonNode.rx.tap.asObservable()
  }
}
