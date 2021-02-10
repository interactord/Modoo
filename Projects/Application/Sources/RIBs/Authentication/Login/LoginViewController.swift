import AsyncDisplayKit
import ReactorKit
import RIBs
import RxCocoa
import RxOptional
import RxSwift
import RxTexture2

// MARK: - LoginPresentableAction

enum LoginPresentableAction: Equatable {
  case login
  case register
  case password(String)
  case email(String)
  case loading(Bool)
}

// MARK: - LoginPresentableListener

protocol LoginPresentableListener: AnyObject {
  typealias Action = LoginPresentableAction
  typealias State = LoginDisplayModel.State

  var action: ActionSubject<Action> { get }
  var state: Observable<State> { get }
  var currentState: State { get }
}

// MARK: - LoginViewController

final class LoginViewController: ASDKViewController<LoginContainerNode>, LoginPresentable, LoginViewControllable
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
    print("LoginViewController deinit...")
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
    node.emailInputNode.textView?.rx.text
      .filterNil()
      .map{ .email($0) }
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    node.passwordInputNode.textView?.rx.text
      .filterNil()
      .map{ .password($0) }
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    node.dontHaveAccountButtonNode.rx.tap
      .map{ _ in .register }
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    node.loginButtonNode.rx.tap
      .map { _ in .login }
      .bind(to: listener.action)
      .disposed(by: disposeBag)
  }
}
