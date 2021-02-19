import AsyncDisplayKit
import RxCocoa
import RxKeyboard
import RxSwift

// MARK: - LoginContainerNode

final class LoginContainerNode: ASDisplayNode {

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
    print("LoginContainerNode deinit...")
  }

  // MARK: Internal

  let dontHaveAccountButtonNode = FormSecondaryButtonNode(type: .signIn)
  let loginFormNode = LoginFormNode()

  // MARK: Private

  private struct Const {
    static let containerPadding =
      UIEdgeInsets(top: 0, left: 30.0, bottom: 30.0, right: 30.0)
  }

  private let keyboardDismissEventNode = ASControlNode()
  private let disposeBag = DisposeBag()
  private var backgroundNode = ASDisplayNode()

}

// MARK: Binding

extension LoginContainerNode {
  private func observeKeyboard() {
    [
      keyboardDismissEventNode.rx.tap,
      loginFormNode.keyboardDismissEventNode.rx.tap,
    ]
    .forEach {
      $0.withUnretained(view)
        .subscribe(onNext: { $0.0.endEditing(true) })
        .disposed(by: self.disposeBag)
    }

    RxKeyboard.instance.visibleHeight
      .withUnretained(loginFormNode.view)
      .drive(onNext: { $0.0.scrollWhenKeyboardEvent(height: $0.1) })
      .disposed(by: disposeBag)
  }

  private func observeFormField() {
    let emailValidObservable = loginFormNode.emailInputNode.stateStream.map({ $0 == .valid })
    let passwordObservable = loginFormNode.passwordInputNode.stateStream.map({ $0 == .valid })

    Observable.combineLatest(
      emailValidObservable,
      passwordObservable) { ($0, $1) }
      .map { $0 && $1 }
      .bind(to: loginFormNode.loginButtonNode.rx.isEnabled)
      .disposed(by: disposeBag)

    let backgroundScheduler = SerialDispatchQueueScheduler(qos: .default)

    loginFormNode.emailInputNode
      .editingDidEndOnExitEventStream
      .withLatestFrom(loginFormNode.passwordInputNode.inputTextStream)
      .observe(on: backgroundScheduler)
      .observe(on: MainScheduler.instance)
      .filter{ $0.isEmpty }
      .map{ _ in Void() }
      .bind(to: loginFormNode.passwordInputNode.becomeFirstResponderBinder)
      .disposed(by: disposeBag)
  }
}

// MARK: - LayoutSpec

extension LoginContainerNode {

  // MARK: Internal

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentsLayout = ASOverlayLayoutSpec(child: loginFormNode, overlay: registerAreaLayoutSpec())
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
        dontHaveAccountButtonNode,
      ])
  }

}
