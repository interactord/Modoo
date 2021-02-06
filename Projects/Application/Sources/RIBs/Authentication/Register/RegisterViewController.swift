import AsyncDisplayKit
import ReactorKit
import RIBs
import RxCocoa
import RxSwift
import UIKit

// MARK: - RegisterPresentableAction

enum RegisterPresentableAction {
  case signUp
  case login
}

// MARK: - RegisterPresentableState

struct RegisterPresentableState: Equatable {
  let email = ""
  let paswword = ""
  let fullName = ""
  let userName = ""
}

// MARK: - RegisterPresentableListener

protocol RegisterPresentableListener: AnyObject {
  typealias Action = RegisterPresentableAction
  typealias State = RegisterPresentableState

  var action: ActionSubject<Action> { get }
  var state: Observable<State> { get }
  var currentState: State { get }
}

// MARK: - RegisterViewController

final class RegisterViewController: ASDKViewController<RegisterContainerNode>, RegisterPresentable {

  // MARK: Lifecycle

  override init() {
    super.init(node: .init())
  }

  deinit {
    print("RegisterViewController deinit...")
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  weak var listener: RegisterPresentableListener?
  let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()

    bind(listener: listener)
  }

}

// MARK: RegisterViewControllable

extension RegisterViewController: RegisterViewControllable {
}

// MARK: Binding

extension RegisterViewController {

  private func bind(listener: RegisterPresentableListener?) {
    guard let listener = listener else { return }
    bindAction(listener: listener)
  }

  private func bindAction(listener: RegisterPresentableListener) {
    node.signUpButtonNode.rx.tap
      .map{ _ in .signUp }
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    node.alreadyHaveAccountButtonNode.rx.tap
      .map{ _ in .login }
      .bind(to: listener.action)
      .disposed(by: disposeBag)
  }
}
