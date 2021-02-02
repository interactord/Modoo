import UIKit

import RIBs
import RxSwift

// MARK: - AuthenticationPresentableListener

protocol AuthenticationPresentableListener: AnyObject {
}

// MARK: - AuthenticationViewController

final class AuthenticationViewController: UIViewController, AuthenticationPresentable, AuthenticationViewControllable {

  weak var listener: AuthenticationPresentableListener?
}
