import AsyncDisplayKit
import BonMot
import ReactorKit
import RxOptional
import RxSwift
import RxTexture2

// MARK: - FormTextInputNode

final class FormTextInputNode: ASDisplayNode & View {

  // MARK: Lifecycle

  init(scope: FormTextInputReactor.Scope) {
    defer { reactor = .init() }
    self.scope = scope
    super.init()
    automaticallyManagesSubnodes = true
  }

  deinit {
    print("FormTextInputNode deinit..")
  }

  // MARK: Internal

  var disposeBag = DisposeBag()

  let backgroundNode: ASDisplayNode = {
    let node = ASDisplayNode()
    node.backgroundColor = Const.backgroundColor
    node.cornerRadius = Const.connerRadius
    node.borderWidth = 1
    node.borderColor = Const.backgroundColor.cgColor
    return node
  }()

  var textView: UITextField? {
    textFiledNode.view as? UITextField
  }

  override func didLoad() {
    super.didLoad()
    // Todo: 나중에 이부분 손봐야함 (기능변경 대상)
    textView?.returnKeyType = scope == .email ? .next : .join

    textView?.clearButtonMode = .whileEditing
    textView?.clearsOnInsertion = scope.clearsOnInsertion
    textView?.isSecureTextEntry = scope.isSecureTextEntity
    textView?.attributedPlaceholder = scope.placeholderString.styled(with: Const.placeholderTextStyle)
    textView?.defaultTextAttributes = Const.typingTextStyle.attributes
  }

  func bind(reactor: FormTextInputReactor) {
    bindAction(with: reactor)
  }

  // MARK: Private

  private struct Const {
    static let fieldHeight = ASDimension(unit: .points, value: 14.0)
    static let placeholderTextStyle =
      StringStyle(.font(.systemFont(ofSize: 14)), .color(UIColor.white.withAlphaComponent(0.8)))
    static let typingTextStyle =
      StringStyle(.font(.systemFont(ofSize: 14)), .color(.white))
    static let backgroundColor = UIColor.white.withAlphaComponent(0.1)
    static let selectedStateColor = UIColor.white.withAlphaComponent(0.3)
    static let contentsPadding =
      UIEdgeInsets(top: 15, left: 16, bottom: 15, right: 16)
    static let connerRadius: CGFloat = 5.0
  }

  private let textFiledNode: ASDisplayNode = {
    let node = ASDisplayNode(viewBlock: { UITextField() })
    node.style.height = Const.fieldHeight
    return node
  }()

  private let messageNode: ASTextNode = {
    let node = ASTextNode()
    node.maximumNumberOfLines = 1
    node.isHidden = true
    return node
  }()

  private let scope: FormTextInputReactor.Scope

}

// MARK: Binding

extension FormTextInputNode {
  private func bindAction(with reactor: FormTextInputReactor) {

    textView?.rx
      .controlEvent(.editingChanged)
      .map { _ in Const.selectedStateColor.cgColor }
      .bind(to: backgroundNode.rx.borderColor)
      .disposed(by: disposeBag)

    textView?.rx
      .controlEvent([.editingDidEnd, .editingDidEndOnExit])
      .map { _ in Const.backgroundColor.cgColor }
      .bind(to: backgroundNode.rx.borderColor)
      .disposed(by: disposeBag)

    textView?.rx
      .controlEvent(.editingChanged)
      .withUnretained(self)
      .map { owner, _ in
        .editingChanged(owner.scope, owner.textView?.text)
      }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
  }
}

// MARK: LayoutSpec

extension FormTextInputNode {

  // MARK: Internal

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentsLayoutWidthPadding = ASInsetLayoutSpec(
      insets: Const.contentsPadding,
      child: contentsLayoutSpec())

    return ASBackgroundLayoutSpec(
      child: contentsLayoutWidthPadding,
      background: backgroundNode)

  }

  // MARK: Private

  private func contentsLayoutSpec() -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .vertical,
      spacing: .zero,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        textFiledNode,
      ])
  }

}
