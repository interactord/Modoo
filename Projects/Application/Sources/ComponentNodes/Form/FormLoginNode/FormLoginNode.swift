import AsyncDisplayKit
import ReactorKit
import RxSwiftExt

// MARK: - FormLoginNode

final class FormLoginNode: ASScrollNode, View {

  // MARK: Lifecycle

  init(
    emailInputNode: TextInputNodeViewable = FormTextInputNode(scope: .email),
    passwordInputNode: TextInputNodeViewable = FormTextInputNode(scope: .password))
  {
    defer { reactor = .init() }
    self.emailInputNode = emailInputNode
    self.passwordInputNode = passwordInputNode
    super.init()
    automaticallyManagesContentSize = true
    automaticallyManagesSubnodes = true
    backgroundColor = .clear
  }

  deinit {
    print("LoginFormNode deinit...")
  }

  // MARK: Internal

  var disposeBag = DisposeBag()

  let logoNode: ASImageNode = {
    let node = ASImageNode()
    node.image = #imageLiteral(resourceName: "instargram-logo")
    node.tintColor = Const.logoTintColor
    node.contentMode = .scaleAspectFit
    node.style.preferredSize = Const.logoSize
    node.isLayerBacked = true
    return node
  }()

  let emailInputNode: TextInputNodeViewable
  let passwordInputNode: TextInputNodeViewable
  let loginButtonNode = FormPrimaryButtonNode(type: .login)
  let forgetPasswordButton = FormSecondaryButtonNode(type: .helpSignIn)
  let keyboardDismissEventNode = ASControlNode()

  func bind(reactor: FormLoginReactor) {
    bindAction(reactor: reactor)
    bindState(reactor: reactor)
  }

  // MARK: Private

  private struct Const {
    static let logoTintColor = UIColor.white
    static let logoSize = CGSize(width: 220, height: 80)
    static let inputFieldSpacing: CGFloat = 20.0
    static let logoPadding =
      UIEdgeInsets(top: 0.0, left: 0, bottom: 24, right: 0)
  }

}

extension FormLoginNode {
  private func bindAction(reactor: FormLoginReactor) {
    emailInputNode
      .inputTextStream
      .map { .typingEmail($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

    passwordInputNode
      .inputTextStream
      .map{ .typingPassword($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

    Observable.combineLatest(
      emailInputNode.stateStream.map({ $0 == .valid }),
      passwordInputNode.stateStream.map({ $0 == .valid })) { ($0, $1) }
      .map { .isAllInputValid($0 && $1) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

    emailInputNode
      .editingDidEndOnExitEventStream
      .withLatestFrom(passwordInputNode.inputTextStream)
      .observe(on: SerialDispatchQueueScheduler(qos: .default))
      .observe(on: MainScheduler.instance)
      .filter { $0.isEmpty }
      .mapTo(Void())
      .bind(to: passwordInputNode.becomeFirstResponderBinder)
      .disposed(by: disposeBag)
  }

  private func bindState(reactor: FormLoginReactor) {
    reactor.state
      .map{ $0.isAllInputValid }
      .bind(to: loginButtonNode.rx.isEnabled)
      .disposed(by: disposeBag)
  }
}

// MARK: LoginViewable

extension FormLoginNode: LoginViewable {
  var node: ASScrollNode { self }

  var stateStream: Observable<FormLoginReactor.State> {
    reactor?.state ?? .empty()
  }

  var loginTabStream: Observable<Void> {
    loginButtonNode.rx.tap.asObservable()
  }

  var helpSignInTapStream: Observable<Void> {
    forgetPasswordButton.rx.tap.asObservable()
  }

  var keyboardDismissEventNodeTapStream: Observable<Void> {
    keyboardDismissEventNode.rx.tap.asObservable()
  }
}

// MARK: - LayoutSpec

extension FormLoginNode {

  // MARK: Internal

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: 14.0,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        logoAreaLayoutSpec(),
        inputFieldAreaLayoutSpec(),
      ])

    return ASOverlayLayoutSpec(
      child: keyboardDismissEventNode,
      overlay: contentLayout)
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
        loginButtonNode,
        forgetPasswordButton,
      ])
  }

  private func logoAreaLayoutSpec() -> ASLayoutSpec {
    let stackLayout = ASStackLayoutSpec(
      direction: .horizontal,
      spacing: .zero,
      justifyContent: .center,
      alignItems: .stretch,
      children: [logoNode])

    return ASInsetLayoutSpec(
      insets: Const.logoPadding,
      child: stackLayout)
  }
}
