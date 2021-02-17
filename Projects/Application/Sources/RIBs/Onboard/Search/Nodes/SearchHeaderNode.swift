import AsyncDisplayKit

// MARK: - SearchHeaderNode

final class SearchHeaderNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    super.init()

    automaticallyManagesSubnodes = true
    backgroundColor = .white
  }

  deinit {
    print("SearchHeaderNode deinit...")
  }

  // MARK: Internal

  let searchField = SearchFieldNode()

  // MARK: Private

  private struct Const {
    static var contentPadding = UIEdgeInsets(top: 12.5, left: 7, bottom: 12, right: 7)
  }
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
        searchField,
      ])

    return ASInsetLayoutSpec(
      insets: Const.contentPadding,
      child: contentLayout)
  }
}
