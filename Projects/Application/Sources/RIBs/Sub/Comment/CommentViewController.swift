import RIBs
import RxSwift
import UIKit

// MARK: - CommentPresentableListener

protocol CommentPresentableListener: AnyObject {
}

// MARK: - CommentViewController

final class CommentViewController: UIViewController, CommentPresentable, CommentViewControllable {

  // MARK: Lifecycle

  deinit {
    print("CommentViewController deinit...")
  }

  // MARK: Internal

  weak var listener: CommentPresentableListener?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red
  }

}
