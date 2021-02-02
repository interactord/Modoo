import AsyncDisplayKit
import RIBs
import RxSwift

// MARK: - LoginPresentableListener

protocol LoginPresentableListener: AnyObject {
  func loginAction()
  func registerAction()
}

// MARK: - LoginViewController

final class LoginViewController: ASDKViewController<LoginContainerNode>, LoginPresentable, LoginViewControllable {

  // MARK: Lifecycle

  override init() {
    super.init(node: .init())
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    print("LoginController deinit...")
  }

  // MARK: Internal

  weak var listener: LoginPresentableListener?

  override func viewDidLoad() {
    super.viewDidLoad()

    node.dontHaveAccountButton.addTarget(self, action: #selector(onRegister), forControlEvents: .touchUpInside)
    node.loginButton.addTarget(self, action: #selector(onLogin), forControlEvents: .touchUpInside)
  }

  @objc
  func onLogin(sender: Any) {
    listener?.loginAction()
  }

  @objc
  func onRegister(sender: Any) {
    listener?.registerAction()
  }
}
