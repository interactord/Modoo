import AsyncDisplayKit
import RxCocoa
import RxKeyboard
import RxSwift

// MARK: - RegisterContainerNode

final class RegisterContainerNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    super.init()
    automaticallyManagesSubnodes = true
    automaticallyRelayoutOnSafeAreaChanges = true
    backgroundColor = .black
    observeFormField()
    observeKeyboard()
  }

  deinit {
    print("RegisterContainerNode deinit...")
  }

  // MARK: Internal

  let alreadyHaveAccountButtonNode = FormSecondaryButtonNode(type: .signUp)

  let registerFormNode = RegisterFormNode()

  // MARK: Private

  private struct Const {
    static let containerPadding =
      UIEdgeInsets(top: 30.0, left: 30.0, bottom: 30.0, right: 30.0)
  }

  private let keyboardDismissEventNode = ASControlNode()
  private var keyboardVisibleHeight: CGFloat = 0.0
  private var backgroundNode = ASDisplayNode()
  private let disposeBag = DisposeBag()

}

// MARK: Binding

extension RegisterContainerNode {
  private func observeFormField() {
    guard
      let emailValidObservable = registerFormNode.emailInputNode.reactor?.state.map( { $0.statue == .valid }),
      let emailInputTextView = registerFormNode.emailInputNode.textView,
      let passwordValidObservable = registerFormNode.passwordInputNode.reactor?.state.map( { $0.statue == .valid }),
      let passwordInputTextView = registerFormNode.passwordInputNode.textView,
      let fullNameValidObservable = registerFormNode.fullNameInputNode.reactor?.state.map( { $0.statue == .valid }),
      let fullNameInputTextView = registerFormNode.fullNameInputNode.textView,
      let userNameValidObservable = registerFormNode.usernameInputNode.reactor?.state.map( { $0.statue == .valid }),
      let userNameInputTextView = registerFormNode.usernameInputNode.textView
    else { return }

    Observable.combineLatest(
      emailValidObservable,
      passwordValidObservable,
      fullNameValidObservable,
      userNameValidObservable) { ($0, $1, $2, $3) }
      .map { $0 && $1 && $2 && $3 }
      .bind(to: registerFormNode.signUpButtonNode.rx.isEnabled)
      .disposed(by: disposeBag)

    let backgroundScheduler = SerialDispatchQueueScheduler(qos: .default)
    keyboardReturnBinding(
      from: emailInputTextView,
      to: passwordInputTextView,
      backgroundScheduler: backgroundScheduler)
    keyboardReturnBinding(
      from: passwordInputTextView,
      to: fullNameInputTextView,
      backgroundScheduler: backgroundScheduler)
    keyboardReturnBinding(
      from: fullNameInputTextView,
      to: userNameInputTextView,
      backgroundScheduler: backgroundScheduler)
  }

  private func observeKeyboard() {
    [
      keyboardDismissEventNode.rx.tap,
      registerFormNode.keyboardDismissEventNode.rx.tap,
    ]
    .forEach {
      $0.withUnretained(view)
        .subscribe(onNext: { $0.0.endEditing(true) })
        .disposed(by: self.disposeBag)
    }

    RxKeyboard.instance.visibleHeight
      .withUnretained(registerFormNode.view)
      .drive(onNext: { $0.0.scrollWhenKeyboardEvent(height: $0.1) })
      .disposed(by: disposeBag)
  }

  private func keyboardReturnBinding(
    from: UITextField,
    to: UITextField,
    backgroundScheduler: SerialDispatchQueueScheduler)
  {
    from.rx.controlEvent(.editingDidEndOnExit)
      .withLatestFrom(to.rx.text)
      .observe(on: backgroundScheduler)
      .observe(on: MainScheduler.instance)
      .filter{ $0?.isEmpty ?? false }
      .subscribe(onNext: { _ in
        to.becomeFirstResponder()
      }).disposed(by: disposeBag)
  }

}

// MARK: - LayoutSpec

extension RegisterContainerNode {

  // MARK: Internal

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentsLayout = ASOverlayLayoutSpec(
      child: registerFormNode,
      overlay: registerAreaLayoutSpec())
    let containerLayout = ASInsetLayoutSpec(
      insets: .merge(list: [safeAreaInsets, Const.containerPadding]),
      child: contentsLayout)

    let touchableLayout = ASOverlayLayoutSpec(
      child: keyboardDismissEventNode,
      overlay: containerLayout)

    return ASBackgroundLayoutSpec(
      child: touchableLayout,
      background: backgroundNode)
  }

  // MARK: Private

  private func registerAreaLayoutSpec() -> ASLayoutSpec {
    let flexibleTopLayout = ASLayoutSpec()
    flexibleTopLayout.style.flexGrow = 1

    return ASStackLayoutSpec(
      direction: .vertical,
      spacing: .zero,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        flexibleTopLayout,
        alreadyHaveAccountButtonNode,
      ])
  }
}

// MARK: - Preview

import SwiftUI

private let deviceNames: [String] = [
  "iPod touch", "iPhone 11 Pro Max",
]

// MARK: - RegisterContainerNodePreview

struct RegisterContainerNodePreview: PreviewProvider {

  static var previews: some SwiftUI.View {
    ForEach(deviceNames, id: \.self) { deviceName in
      UIViewControllerPreview {
        RegisterViewController(mediaPickerUseCase: UIMediaPickerPlatformUseCase())
      }
      .previewDevice(PreviewDevice(rawValue: deviceName))
      .previewDisplayName(deviceName)
    }
  }
}
