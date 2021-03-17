import AsyncDisplayKit
import RIBs
import RxSwift
import UIKit

// MARK: - SubFeedPresentableListener

protocol SubFeedPresentableListener: AnyObject {
}

// MARK: - SubFeedViewController

final class SubFeedViewController: ASDKViewController<SubFeedContainerNode>, SubFeedPresentable, SubFeedViewControllable {

  // MARK: Lifecycle

  deinit {
    print("SubFeedViewController deinit...")
  }

  // MARK: Internal

  weak var listener: SubFeedPresentableListener?

  override func loadView() {
    super.loadView()
    view.backgroundColor = .white
  }

}
