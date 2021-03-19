import AsyncDisplayKit
import ReactorKit

// MARK: - FormRegisterNode

final class FormRegisterNode: ASScrollNode, View {

  // MARK: Lifecycle

  init(
    emailInputNode: TextInputNodeViewable = FormTextInputNode(scope: .email),
    passwordInputNode: TextInputNodeViewable = FormTextInputNode(scope: .password),
    fullNameInputNode: TextInputNodeViewable = FormTextInputNode(scope: .plain(placeholderString: "Fullname")),
    usernameInputNode: TextInputNodeViewable = FormTextInputNode(scope: .plain(placeholderString: "Username")))
  {
    defer { reactor = .init() }
    self.emailInputNode = emailInputNode
    self.passwordInputNode = passwordInputNode
    self.fullNameInputNode = fullNameInputNode
    self.usernameInputNode = usernameInputNode
    super.init()
    automaticallyManagesContentSize = true
    automaticallyManagesSubnodes = true
    backgroundColor = .clear
    view.keyboardDismissMode = .onDrag
  }

  deinit {
    print("FormRegisterNode deinit...")
  }

  // MARK: Internal

  let plusButtonNode: ASButtonNode = {
    let node = ASButtonNode()
    node.setImage(#imageLiteral(resourceName: "register-photo"), for: .normal)
    node.tintColor = Const.plusButtonTintColor
    node.style.preferredSize = Const.plusButtonSize
    node.cornerRadius = Const.plusButtonSize.width / 2
    node.borderWidth = 1
    node.borderColor = Const.plusButtonTintColor.cgColor
    node.clipsToBounds = true
    return node
  }()

  let emailInputNode: TextInputNodeViewable
  let passwordInputNode: TextInputNodeViewable
  let fullNameInputNode: TextInputNodeViewable
  let usernameInputNode: TextInputNodeViewable
  let signUpButtonNode = FormPrimaryButtonNode(type: .signUp)
  let keyboardDismissEventNode = ASControlNode()

  var disposeBag = DisposeBag()

  func bind(reactor: FormRegisterReactor) {
    bindAction(reactor: reactor)
    bindState(reactor: reactor)
  }

  // MARK: Private

  private struct Const {
    static let plusButtonTintColor = UIColor.white
    static let plusButtonSize = CGSize(width: 120, height: 120)
    static let plusPadding = UIEdgeInsets(top: 00, left: 0, bottom: 20, right: 0)
    static let inputFieldSpacing: CGFloat = 20.0
    static let containerPadding =
      UIEdgeInsets(top: 30.0, left: 30.0, bottom: 30.0, right: 30.0)
  }

}

extension FormRegisterNode {
  private func bindAction(reactor: FormRegisterReactor) {
    emailInputNode
      .inputTextStream
      .map{ .typingEmail($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

    passwordInputNode
      .inputTextStream
      .map{ .typingPassword($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

    fullNameInputNode
      .inputTextStream
      .map{ .typingFullName($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

    usernameInputNode
      .inputTextStream
      .map{ .typingUserName($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

    let emailValidationStream = emailInputNode.stateStream.map({ $0 == .valid })
    let passwordValidationStream = passwordInputNode.stateStream.map({ $0 == .valid })
    let fullNameValidationStream = fullNameInputNode.stateStream.map({ $0 == .valid })
    let userNameValidationStream = usernameInputNode.stateStream.map({ $0 == .valid })

    Observable.combineLatest(
      emailValidationStream,
      passwordValidationStream,
      fullNameValidationStream,
      userNameValidationStream) { ($0, $1, $2, $3) }
      .map { .isAllInputValid($0 && $1 && $2 && $3) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

    let backgroundScheduler = SerialDispatchQueueScheduler(qos: .default)

    keyboardReturnBinding(
      from: emailInputNode,
      to: passwordInputNode,
      backgroundScheduler: backgroundScheduler)
    keyboardReturnBinding(
      from: passwordInputNode,
      to: fullNameInputNode,
      backgroundScheduler: backgroundScheduler)
    keyboardReturnBinding(
      from: fullNameInputNode,
      to: usernameInputNode,
      backgroundScheduler: backgroundScheduler)
  }

  private func bindState(reactor: FormRegisterReactor) {
    reactor.state
      .map { $0.isAllInputValid }
      .bind(to: signUpButtonNode.rx.isEnabled)
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

// MARK: FormRegisterNodeViewable

extension FormRegisterNode: FormRegisterNodeViewable {
  var node: ASScrollNode { self }

  var stateStream: Observable<FormRegisterReactor.State> {
    reactor?.state ?? .empty()
  }

  var signUpButtonTapStream: Observable<Void> {
    signUpButtonNode.rx.tap.asObservable()
  }

  var plusButtonTapStream: Observable<Void> {
    plusButtonNode.rx.tap.asObservable()
  }

  var keyboardDismissEventNodeTapStream: Observable<Void> {
    keyboardDismissEventNode.rx.tap.asObservable()
  }

  var plusButtonImageBinder: Binder<UIImage?> {
    Binder(self) { owner, image in
      owner.plusButtonNode.setImage(image, for: .normal)
    }
  }
}

// MARK: - LayouSpec

extension FormRegisterNode {

  // MARK: Internal

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentsLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: .zero,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        plusButtonAreaLayoutSpec(),
        inputFieldAreaLayoutSpec(),
      ])

    return ASOverlayLayoutSpec(
      child: keyboardDismissEventNode,
      overlay: contentsLayout)
  }

  // MARK: Private

  private func inputFieldAreaLayoutSpec() -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .vertical,
      spacing: Const.inputFieldSpacing,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        emailInputNode.node,
        passwordInputNode.node,
        fullNameInputNode.node,
        usernameInputNode.node,
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
