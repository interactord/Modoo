import AsyncDisplayKit
import ReactorKit
import RIBs
import RxCocoa
import RxOptional
import RxSwift
import RxSwiftExt
import RxTexture2

// MARK: - LoginPresentableListener

protocol LoginPresentableListener: AnyObject {
  var action: ActionSubject<LoginDisplayModel.Action> { get }
  var state: Observable<LoginDisplayModel.State> { get }
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

// MARK: ListenerBindable

extension LoginViewController: ListenerBindable {

  func bindAction(listener: LoginPresentableListener) {
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
