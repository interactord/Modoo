import AsyncDisplayKit

// MARK: - ProfileContainerNode

final class ProfileContainerNode: ASDisplayNode {

  override init() {
    super.init()

    automaticallyManagesSubnodes = true
    automaticallyRelayoutOnSafeAreaChanges = true
    backgroundColor = .red
  }

  deinit {
    print("ProfileContainerNode deinit...")
  }
}

// MARK: - LayoutSpec

extension ProfileContainerNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    ASLayoutSpec()
  }
}
