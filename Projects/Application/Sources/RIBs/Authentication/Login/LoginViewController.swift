import AsyncDisplayKit
import ReactorKit
import RIBs
import RxCocoa
import RxOptional
import RxSwift
import RxSwiftExt
import RxTexture2

// MARK: - LoginPresentableAction

enum LoginPresentableAction: Equatable {
  case loginState(FormLoginReactor.State)
  case login
  case register
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

  deinit {
    print("LoginViewController deinit...")
  }

  // MARK: Internal

  let disposeBag = DisposeBag()

  weak var listener: LoginPresentableListener? {
    didSet { bind(listener: listener) }
  }

}

extension LoginViewController {

  private func bind(listener: LoginPresentableListener?) {
    guard let listener = listener else { return }
    bindAction(listener: listener)
  }

  private func bindAction(listener: LoginPresentableListener) {
    node.loginFormNode
      .stateStream
      .map { .loginState($0) }
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    node.dontHaveAccountButtonNode.rx.tap
      .mapTo(.register)
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    node.loginFormNode
      .loginTabStream
      .mapTo(.login)
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    listener.state
      .filter{ $0.errorMessage != "" }
      .subscribe(onNext: { print($0) })
      .disposed(by: disposeBag)
  }
}
