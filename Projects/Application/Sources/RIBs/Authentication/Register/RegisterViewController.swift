import AsyncDisplayKit
import ReactorKit
import RIBs
import RxCocoa
import RxOptional
import RxSwift
import RxSwiftExt
import UIKit

// MARK: - RegisterPresentableListener

protocol RegisterPresentableListener: AnyObject {
  var action: ActionSubject<RegisterDisplayModel.Action> { get }
  var state: Observable<RegisterDisplayModel.State> { get }
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

  let disposeBag = DisposeBag()
  let mediaPickerUseCase: MediaPickerUseCase

  weak var listener: RegisterPresentableListener? {
    didSet { bind(listener: listener) }
  }

}

// MARK: RegisterViewControllable

extension RegisterViewController: RegisterViewControllable {
}

// MARK: ListenerBindable

extension RegisterViewController: ListenerBindable {

  func bindAction(listener: RegisterPresentableListener) {
    node.registerFormNode.signUpButtonTapStream
      .mapTo(.signUp)
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    node.alreadyHaveAccountButtonNode.rx.tap
      .map{ _ in .login }
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    let plusButtonObserver = node.registerFormNode.plusButtonTapStream
      .observe(on: MainScheduler.instance)
      .withUnretained(self)
      .flatMap {
        $0.0.mediaPickerUseCase
          .selectImage(targetViewController: $0.0, source: .photoLibrary, allowsEditing: false)
      }
      .map { $0.0 }
      .share()

    plusButtonObserver
      .bind(to: node.registerFormNode.plusButtonImageBinder)
      .disposed(by: disposeBag)

    plusButtonObserver
      .map { .photo($0) }
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    node.registerFormNode
      .stateStream
      .map{ .registerFormState($0) }
      .bind(to: listener.action)
      .disposed(by: disposeBag)
  }

  func bindState(listener: RegisterPresentableListener) {
    listener.state
      .map { $0.errorMessage }
      .filterEmpty()
      .subscribe(onNext: { message in
        print(message)
      })
      .disposed(by: disposeBag)
  }
}
