import AsyncDisplayKit
import RxCocoa
import RxSwift

// MARK: - RegisterContainerNode

final class RegisterContainerNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    defer {
      observeFormField()
    }
    super.init()
    automaticallyManagesSubnodes = true
    automaticallyRelayoutOnSafeAreaChanges = true
    backgroundColor = .black
  }

  deinit {
    print("RegisterContainerNode deinit...")
  }

  // MARK: Internal

  let plusButtonNode: ASButtonNode = {
    let node = ASButtonNode()
    node.setImage(#imageLiteral(resourceName: "register-photo"), for: .normal)
    node.tintColor = Const.plusButtonTintColor
    node.style.preferredSize = Const.plusButtonSize
    return node
  }()

  let emailInputNode: FormTextInputNode = FormTextInputNode(scope: .email)
  let passwordInputNode = FormTextInputNode(scope: .password)
  let fullNameInputNode = FormTextInputNode(scope: .plain(placeholderString: "Fullname"))
  let usernameInputNode = FormTextInputNode(scope: .plain(placeholderString: "Username"))
  let signUpButtonNode = FormPrimaryButtonNode(type: .signUp)
  let alreadyHaveAccountButtonNode = FormSecondaryButtonNode(type: .signUp)

  // MARK: Private

  private struct Const {
    static let plusButtonTintColor = UIColor.white
    static let plusButtonSize = CGSize(width: 140, height: 140)
    static let plusPadding = UIEdgeInsets(top: 30, left: 0, bottom: 24, right: 0)
    static let inputFieldSpacing: CGFloat = 20.0
    static let containerPadding =
      UIEdgeInsets(top: 0.0, left: 30.0, bottom: 0.0, right: 30.0)
  }

  private var backgroundNode = ASDisplayNode()
  private let disposeBag = DisposeBag()

}

// MARK: Binding

extension RegisterContainerNode {
  private func observeFormField() {
    guard
      let emailValidObservable = emailInputNode.reactor?.state.map( { $0.statue == .valid }),
      let emailInputTextView = emailInputNode.textView,
      let passwordValidObservable = passwordInputNode.reactor?.state.map( { $0.statue == .valid }),
      let passwordInputTextView = passwordInputNode.textView,
      let fullNameValidObservable = fullNameInputNode.reactor?.state.map( { $0.statue == .valid }),
      let fullNameInputTextView = fullNameInputNode.textView,
      let userNameValidObservable = usernameInputNode.reactor?.state.map( { $0.statue == .valid }),
      let userNameInputTextView = usernameInputNode.textView
    else { return }

    Observable.combineLatest(
      emailValidObservable,
      passwordValidObservable,
      fullNameValidObservable,
      userNameValidObservable) { ($0, $1, $2, $3) }
      .map { $0 && $1 && $2 && $3 }
      .bind(to: signUpButtonNode.rx.isEnabled)
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

  private func keyboardReturnBinding(from: UITextField, to: UITextField, backgroundScheduler: SerialDispatchQueueScheduler) {
    from.rx.controlEvent([.editingDidEndOnExit, .editingDidEnd])
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
    let flexibleSpacingLayout = ASLayoutSpec()
    flexibleSpacingLayout.style.flexGrow = 1.0

    let containerLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: 14.0,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        plusButtonAreaLayoutSpec(),
        inputFieldAreaLayoutSpec(),
        flexibleSpacingLayout,
        alreadyHaveAccountButtonNode,
      ])

    let contentsLayout = ASInsetLayoutSpec(
      insets: .merge(list: [safeAreaInsets, Const.containerPadding]),
      child: containerLayout)

    return ASBackgroundLayoutSpec(
      child: contentsLayout,
      background: backgroundNode)
  }

  // MARK: Private

  private func inputFieldAreaLayoutSpec() -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .vertical,
      spacing: Const.inputFieldSpacing,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        emailInputNode,
        passwordInputNode,
        fullNameInputNode,
        usernameInputNode,
        signUpButtonNode,
      ])
  }

  private func plusButtonAreaLayoutSpec() -> ASLayoutSpec {
    let stackLayout = ASStackLayoutSpec(
      direction: .horizontal,
      spacing: .zero,
      justifyContent: .center,
      alignItems: .stretch,
      children: [plusButtonNode])

    return ASInsetLayoutSpec(
      insets: Const.plusPadding,
      child: stackLayout)
  }
}
