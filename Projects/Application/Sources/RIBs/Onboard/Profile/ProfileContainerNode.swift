import AsyncDisplayKit

// MARK: - ProfileContainerNode

final class ProfileContainerNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    super.init()

    automaticallyManagesSubnodes = true
    automaticallyRelayoutOnSafeAreaChanges = true
    backgroundColor = .white
  }

  deinit {
    print("ProfileContainerNode deinit...")
  }

  // MARK: Internal

  let headerNode = ProfileHeaderNode()
}

// MARK: - LayoutSpec

extension ProfileContainerNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contensLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: .zero,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        headerNode,
      ])

    return ASInsetLayoutSpec(insets: safeAreaInsets, child: contensLayout)
  }
}
