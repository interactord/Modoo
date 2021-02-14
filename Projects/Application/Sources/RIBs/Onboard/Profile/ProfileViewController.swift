import AsyncDisplayKit
import RIBs
import RxSwift
import UIKit

// MARK: - ProfilePresentableListener

protocol ProfilePresentableListener: AnyObject {
}

// MARK: - ProfileViewController

final class ProfileViewController: ASDKViewController<ProfileContainerNode>, ProfilePresentable, ProfileViewControllable {

  // MARK: Lifecycle

  deinit {
    print("ProfileViewController deinit...")
  }

  // MARK: Internal

  weak var listener: ProfilePresentableListener?

  var items = [""]

  override func viewDidLoad() {
    super.viewDidLoad()
    node.collectionNode.dataSource = self
  }

}

// MARK: ASCollectionDataSource

extension ProfileViewController: ASCollectionDataSource {

  func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
    1
  }

  func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
    items.count
  }

  func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
    print("ProfileViewController indexPath -> ", indexPath)

    let cellNodeBlock = { () -> ASCellNode in
      ProfileInformationCell()
    }

    return cellNodeBlock
  }

}
