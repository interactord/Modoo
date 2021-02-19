import AsyncDisplayKit
import RxSwift

// MARK: - SearchHeaderNode

final class SearchHeaderNode: ASDisplayNode {

  // MARK: Lifecycle

  init(searchNode: SearchNodeViewable = FormSearchNode()) {
    self.searchNode = searchNode
    super.init()

    automaticallyManagesSubnodes = true
    backgroundColor = .white
  }

  deinit {
    print("SearchHeaderNode deinit...")
  }

  // MARK: Private

  private struct Const {
    static var contentPadding = UIEdgeInsets(top: 12.5, left: 7, bottom: 12, right: 7)
  }

  private let searchNode: SearchNodeViewable

}

// MARK: - LayoutSpec

extension SearchHeaderNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

    let contentLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: .zero,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        searchNode.node,
      ])

    return ASInsetLayoutSpec(
      insets: Const.contentPadding,
      child: contentLayout)
  }
}
