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
    let emailValidObservable = registerFormNode.emailInputNode.stateStream.map( { $0 == .valid })
    let passwordValidObservable = registerFormNode.passwordInputNode.stateStream.map( { $0 == .valid })
    let fullNameValidObservable = registerFormNode.fullNameInputNode.stateStream.map( { $0 == .valid })
    let userNameValidObservable = registerFormNode.usernameInputNode.stateStream.map( { $0 == .valid })

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
      from: registerFormNode.emailInputNode,
      to: registerFormNode.passwordInputNode,
      backgroundScheduler: backgroundScheduler)
    keyboardReturnBinding(
      from: registerFormNode.passwordInputNode,
      to: registerFormNode.fullNameInputNode,
      backgroundScheduler: backgroundScheduler)
    keyboardReturnBinding(
      from: registerFormNode.fullNameInputNode,
      to: registerFormNode.usernameInputNode,
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
    from: TextInputNodeViewable,
    to: TextInputNodeViewable,
    backgroundScheduler: SerialDispatchQueueScheduler)
  {
    from.editingDidEndOnExitEventStream
      .withLatestFrom(to.inputTextStream)
      .observe(on: backgroundScheduler)
      .observe(on: MainScheduler.instance)
      .filter{ $0.isEmpty }
      .map{ _ in Void() }
      .bind(to: to.becomeFirstResponderBinder)
      .disposed(by: disposeBag)
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
