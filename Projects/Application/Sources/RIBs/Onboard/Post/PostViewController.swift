import AsyncDisplayKit
import RIBs
import RxSwift
import UIKit

// MARK: - PostPresentableListener

protocol PostPresentableListener: AnyObject {
}

// MARK: - PostViewController

final class PostViewController: ASDKViewController<PostContainerNode>, PostPresentable, PostViewControllable {

  // MARK: Lifecycle

  deinit {
    print("PostViewController deinit...")
  }

  // MARK: Internal

  weak var listener: PostPresentableListener?

}
