import RIBs
import RxSwift
import UIKit

// MARK: - FeedPresentableListener

protocol FeedPresentableListener: AnyObject {
}

// MARK: - FeedViewController

final class FeedViewController: UIViewController, FeedPresentable, FeedViewControllable {

  // MARK: Lifecycle

  deinit {
    print("FeedViewController deinit...")
  }

  // MARK: Internal

  weak var listener: FeedPresentableListener?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .darkGray
  }
}
