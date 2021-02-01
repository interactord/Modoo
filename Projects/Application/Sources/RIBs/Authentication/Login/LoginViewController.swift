import AsyncDisplayKit
import RIBs
import RxSwift

// MARK: - LoginPresentableListener

protocol LoginPresentableListener: AnyObject {
  func login()
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
//    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [listener] in
//      listener?.login()
//    }
  }
}
