import RIBs
import RxSwift
import UIKit

// MARK: - RegisterPresentableListener

protocol RegisterPresentableListener: AnyObject {
}

// MARK: - RegisterViewController

final class RegisterViewController: UIViewController, RegisterPresentable {

  weak var listener: RegisterPresentableListener?

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .gray
  }
}

// MARK: RegisterViewControllable

extension RegisterViewController: RegisterViewControllable {
}
