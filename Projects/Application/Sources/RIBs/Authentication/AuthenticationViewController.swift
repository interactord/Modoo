import UIKit

import ReactorKit
import RIBs
import RxCocoa
import RxSwift

// MARK: - AuthenticationPresentableListener

protocol AuthenticationPresentableListener: AnyObject {
}

// MARK: - AuthenticationViewController

final class AuthenticationViewController: UINavigationController, AuthenticationPresentable {

  // MARK: Lifecycle

  deinit {
    print("AuthenticationViewController deinit")
  }

  // MARK: Internal

  weak var listener: AuthenticationPresentableListener?

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    applyUIPreferences()
  }

}

extension AuthenticationViewController {
  fileprivate func applyUIPreferences() {
    navigationBar.isHidden = true
    navigationBar.barStyle  = .black
  }
}

// MARK: AuthenticationViewControllable

extension AuthenticationViewController: AuthenticationViewControllable {
}
