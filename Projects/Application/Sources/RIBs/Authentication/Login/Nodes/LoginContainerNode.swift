import AsyncDisplayKit
import RxCocoa
import RxSwift

// MARK: - LoginContainerNode

final class LoginContainerNode: ASDisplayNode {

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
    print("LoginContainerNode deinit...")
  }

  // MARK: Internal

  private(set) lazy var logoNode: ASImageNode = {
    let node = ASImageNode()
    node.image = #imageLiteral(resourceName: "instargram-logo")
    node.tintColor = Const.logoTintColor
    node.contentMode = .scaleAspectFit
    node.style.preferredSize = Const.logoSize
    return node
  }()

  let emailInputNode: FormTextInputNode = FormTextInputNode(scope: .email)
  let passwordInputNode = FormTextInputNode(scope: .password)
  let loginButtonNode = FormPrimaryButtonNode(type: .login)
  let forgetPasswordButton = FormSecondaryButtonNode(type: .helpSignIn)
  let dontHaveAccountButtonNode = FormSecondaryButtonNode(type: .signIn)

  // MARK: Private

  private struct Const {
    static let logoTintColor = UIColor.white
    static let logoSize = CGSize(width: 220, height: 80)
    static let containerPadding =
      UIEdgeInsets(top: 0.0, left: 30.0, bottom: 0.0, right: 30.0)
    static let signUpButtonHeight =
      ASDimension(unit: .points, value: 50.0)
    static let inputFieldSpacing: CGFloat = 20.0
    static let signUpButtonPadding =
      UIEdgeInsets(top: 30.0, left: 10.0, bottom: 0.0, right: 10.0)
    static let logoPadding =
      UIEdgeInsets(top: 100, left: 0, bottom: 24, right: 0)
  }

  private let disposeBag = DisposeBag()
  private var backgroundNode = ASDisplayNode()

}

// MARK: Binding

extension LoginContainerNode {
  private func observeFormField() {
    guard
      let emailValidObservable =
      emailInputNode.reactor?.state.map({ $0.statue == .valid }),
      let passwordObservable =
      passwordInputNode.reactor?.state.map({ $0.statue == .valid })
    else { return }

    Observable.combineLatest(emailValidObservable, passwordObservable) { ($0, $1) }
      .map { $0 && $1 }
      .bind(to: loginButtonNode.rx.isEnabled)
      .disposed(by: disposeBag)

    guard
      let emailInputTextView = emailInputNode.textView,
      let passwordInputTextView = passwordInputNode.textView else { return }

    let backgroundScheduler = SerialDispatchQueueScheduler(qos: .default)
    emailInputTextView.rx.controlEvent([.editingDidEndOnExit, .editingDidEnd])
      .withLatestFrom(passwordInputTextView.rx.text)
      .observe(on: backgroundScheduler)
      .observe(on: MainScheduler.instance)
      .filter{ $0?.isEmpty ?? false }
      .withUnretained(self)
      .subscribe(onNext: { owner, _ in
        owner.passwordInputNode.textView?.becomeFirstResponder()
      }).disposed(by: disposeBag)
  }
}

// MARK: - LayoutSpec

extension LoginContainerNode {

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
        logoAreaLayoutSpec(),
        inputFiledAreaLayoutSpec(),
        flexibleSpacingLayout,
        dontHaveAccountButtonNode,
      ])

    let contentsLayout = ASInsetLayoutSpec(
      insets: .merge(list: [safeAreaInsets, Const.containerPadding]),
      child: containerLayout)

    return ASBackgroundLayoutSpec(
      child: contentsLayout,
      background: backgroundNode)
  }

  // MARK: Private

  private func inputFiledAreaLayoutSpec() -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .vertical,
      spacing: Const.inputFieldSpacing,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        emailInputNode,
        passwordInputNode,
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
