import RIBs
import RxSwift
import UIKit

// MARK: - RootPresentableListener

protocol RootPresentableListener: AnyObject {
}

// MARK: - RootViewController

class RootViewController: UINavigationController, RootPresentable {

  // MARK: Lifecycle

  deinit {
    print("RootViewController deinit...")
  }

  // MARK: Internal

  weak var listener: RootPresentableListener?

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationBar.isHidden = true
    view.backgroundColor = .white
  }

}

// MARK: RootViewControllable

extension RootViewController: RootViewControllable {
}
