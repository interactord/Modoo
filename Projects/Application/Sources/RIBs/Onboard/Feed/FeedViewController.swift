import AsyncDisplayKit
import RIBs
import RxCocoa
import RxDataSources_Texture
import RxOptional
import RxSwift
import RxTexture2
import UIKit

// MARK: - FeedPresentableListener

protocol FeedPresentableListener: AnyObject {
}

// MARK: - FeedViewController

final class FeedViewController: ASDKViewController<FeedContainerNode>, FeedPresentable, FeedViewControllable {

  // MARK: Lifecycle

  deinit {
    print("FeedViewController deinit...")
  }

  // MARK: Internal

  weak var listener: FeedPresentableListener?

  var items = Array(repeating: "A", count: 10)

  override func viewDidLoad() {
    super.viewDidLoad()
    node.collectionNode.delegate = self
    node.collectionNode.dataSource = self
  }

}

// MARK: ASCollectionDataSource

extension FeedViewController: ASCollectionDataSource {
  func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
    1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    items.count
  }

  func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
    print("indexPath -> ", indexPath)

    let cellNodeBlock = { () -> ASCellNode in
      FeedPostCellNode()
    }

    return cellNodeBlock
  }
}

// MARK: ASCollectionDelegate

extension FeedViewController: ASCollectionDelegate {
}
