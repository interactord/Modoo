import AsyncDisplayKit
import ReactorKit
import RIBs
import RxCocoa
import RxSwift
import RxTexture2

// MARK: - LoginPresentableAction

enum LoginPresentableAction {
  case login
  case register
}

// MARK: - LoginPresentableState

struct LoginPresentableState: Equatable {
  let inputEmail = ""
  let inputPassword = ""
}

// MARK: - LoginPresentableListener

protocol LoginPresentableListener: AnyObject {
  typealias Action = LoginPresentableAction
  typealias State = LoginPresentableState

  var action: ActionSubject<Action> { get }
  var state: Observable<State> { get }
  var currentState: State { get }
}

// MARK: - LoginViewController

final class LoginViewController:
  ASDKViewController<LoginContainerNode>,
  LoginPresentable,
  LoginViewControllable
{

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

  let disposeBag = DisposeBag()

  weak var listener: LoginPresentableListener?

  override func viewDidLoad() {
    super.viewDidLoad()

    bind(listener: listener)
  }

}

extension LoginViewController {

  private func bind(listener: LoginPresentableListener?) {
    guard let listener = listener else { return }
    bindAction(listener: listener)
  }

  private func bindAction(listener: LoginPresentableListener) {
    node.dontHaveAccountButtonNode.rx.tap
      .map { _ in .register}
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    node.loginButtonNode.rx.tap
      .map { _ in .login }
      .bind(to: listener.action)
      .disposed(by: disposeBag)
  }
}