import RIBs
import RxSwift
import UIKit

// MARK: - SearchPresentableListener

protocol SearchPresentableListener: AnyObject {
}

// MARK: - SearchViewController

final class SearchViewController: UIViewController, SearchPresentable, SearchViewControllable {

  // MARK: Lifecycle

  deinit {
    print("SearchViewController deinit...")
  }

  // MARK: Internal

  weak var listener: SearchPresentableListener?
}
