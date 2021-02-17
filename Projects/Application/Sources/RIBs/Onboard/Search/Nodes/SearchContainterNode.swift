import AsyncDisplayKit

// MARK: - SearchContainerNode

final class SearchContainerNode: ASDisplayNode {

  override init() {
    super.init()

    automaticallyManagesSubnodes = true
    automaticallyRelayoutOnSafeAreaChanges = true
  }

  deinit {
    print("SearchContainerNode deinit...")
  }
}

// MARK: - LayoutSpec

extension SearchContainerNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    ASLayoutSpec()
  }

}
