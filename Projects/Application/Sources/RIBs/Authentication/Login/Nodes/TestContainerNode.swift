import AsyncDisplayKit

class TestContainerNode: ASDisplayNode {

  override init() {
    super.init()
    automaticallyManagesSubnodes = true
    backgroundColor = .red
  }

  deinit {
    print("TestContainerNode deninit..")
  }
}
