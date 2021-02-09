import AsyncDisplayKit
import ReactorKit
import RIBs
import RxCocoa
import RxOptional
import RxSwift
import UIKit

// MARK: - RegisterPresentableAction

enum RegisterPresentableAction: Equatable {
  case signUp
  case login
  case photo(UIImage?)
  case email(String)
  case password(String)
  case fullName(String)
  case userName(String)
}

// MARK: - RegisterPresentableListener

protocol RegisterPresentableListener: AnyObject {
  typealias Action = RegisterPresentableAction
  typealias State = RegisterDisplayModel.State

  var action: ActionSubject<Action> { get }
  var state: Observable<State> { get }
  var currentState: State { get }
}

// MARK: - RegisterViewController

final class RegisterViewController: ASDKViewController<RegisterContainerNode>, RegisterPresentable {

  // MARK: Lifecycle

  init(mediaPickerUseCase: MediaPickerUseCase) {
    self.mediaPickerUseCase = mediaPickerUseCase
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

  let mediaPickerUseCase: MediaPickerUseCase

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

    let plusButtonObserver = node.plusButtonNode.rx.tap
      .observe(on: MainScheduler.instance)
      .withUnretained(self)
      .flatMap {
        $0.0.mediaPickerUseCase.selectImage(targetViewController: $0.0, source: .photoLibrary, allowsEditing: false)
      }
      .map { $0.0 }
      .share()

    plusButtonObserver
      .bind(to: node.plusButtonNode.rx.image(for: .normal))
      .disposed(by: disposeBag)

    plusButtonObserver
      .map { .photo($0) }
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    node.emailInputNode.textView?.rx.text
      .filterNil()
      .map { .email($0) }
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    node.passwordInputNode.textView?.rx.text
      .filterNil()
      .map { .password($0) }
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    node.fullNameInputNode.textView?.rx.text
      .filterNil()
      .map { .fullName($0) }
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    node.usernameInputNode.textView?.rx.text
      .filterNil()
      .map { .userName($0) }
      .bind(to: listener.action)
      .disposed(by: disposeBag)
  }
}
