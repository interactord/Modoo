import RIBs
import RxSwift
import UIKit

protocol LoginPresentableListener: AnyObject {
  func login()
}

final class LoginViewController: UIViewController, LoginPresentable, LoginViewControllable {
  weak var listener: LoginPresentableListener?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .blue
  }
}
