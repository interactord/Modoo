import RIBs
import RxSwift
import UIKit

// MARK: - SubProfilePresentableListener

protocol SubProfilePresentableListener: AnyObject {
}

// MARK: - SubProfileViewController

final class SubProfileViewController: UIViewController, SubProfilePresentable, SubProfileViewControllable {

  // MARK: Lifecycle

  deinit {
    print("SubProfileViewController deinit...")
  }

  // MARK: Internal

  weak var listener: SubProfilePresentableListener?
}
