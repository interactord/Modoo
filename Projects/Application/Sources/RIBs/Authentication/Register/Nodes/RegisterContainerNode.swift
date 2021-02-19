import AsyncDisplayKit
import RxCocoa
import RxKeyboard
import RxSwift

// MARK: - RegisterContainerNode

final class RegisterContainerNode: ASDisplayNode {

  // MARK: Lifecycle

  init(registerFormNode: FormRegisterNodeViewable = FormRegisterNode()) {
    self.registerFormNode = registerFormNode
    super.init()
    automaticallyManagesSubnodes = true
    automaticallyRelayoutOnSafeAreaChanges = true
    backgroundColor = .black
    observeKeyboard()
  }

  deinit {
    print("RegisterContainerNode deinit...")
  }

  // MARK: Internal

  let alreadyHaveAccountButtonNode = FormSecondaryButtonNode(type: .signUp)

  let registerFormNode: FormRegisterNodeViewable

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

  private func observeKeyboard() {
    [
      keyboardDismissEventNode.rx.tap.asObservable(),
      registerFormNode.keyboardDismissEventNodeTapStream,
    ]
    .forEach {
      $0.withUnretained(view)
        .subscribe(onNext: { $0.0.endEditing(true) })
        .disposed(by: self.disposeBag)
    }

    RxKeyboard.instance.visibleHeight
      .withUnretained(registerFormNode.node.view)
      .drive(onNext: { $0.0.scrollWhenKeyboardEvent(height: $0.1) })
      .disposed(by: disposeBag)
  }

}

// MARK: - LayoutSpec

extension RegisterContainerNode {

  // MARK: Internal

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentsLayout = ASOverlayLayoutSpec(
      child: registerFormNode.node,
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
