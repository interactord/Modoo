import RIBs
import RxSwift
import UIKit

protocol LoginPresentableListener: class {
  func login()
}

final class LoginViewController: UIViewController, LoginPresentable, LoginViewControllable {
  weak var listener: LoginPresentableListener?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .blue

    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [listener] in
      listener?.login()
    }
  }
}
