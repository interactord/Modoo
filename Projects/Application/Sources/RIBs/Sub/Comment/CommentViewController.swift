import AsyncDisplayKit
import RIBs
import RxSwift
import UIKit

// MARK: - CommentPresentableListener

protocol CommentPresentableListener: AnyObject {
}

// MARK: - CommentViewController

final class CommentViewController: ASDKViewController<CommentContainerNode>, CommentPresentable, CommentViewControllable {

  // MARK: Lifecycle

  deinit {
    print("CommentViewController deinit...")
  }

  // MARK: Internal

  weak var listener: CommentPresentableListener?

}
