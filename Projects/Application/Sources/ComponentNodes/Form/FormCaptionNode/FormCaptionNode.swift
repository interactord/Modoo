import AsyncDisplayKit
import BonMot
import ReactorKit
import RxCocoa
import RxOptional
import RxSwift
import RxTexture2

// MARK: - FormCaptionNode

final class FormCaptionNode: ASDisplayNode, View {

  // MARK: Lifecycle

  init(scope: FormCaptionReactor.Scope) {
    self.scope = scope
    defer { reactor = .init(scope: scope) }
    super.init()
    automaticallyManagesSubnodes = true
  }

  // MARK: Internal

  var disposeBag = DisposeBag()
  let scope: FormCaptionReactor.Scope

  lazy var captionNode: ASEditableTextNode = {
    let node = ASEditableTextNode()
    node.typingAttributes = Const.captingTypingStyle.dictionary
    node.attributedPlaceholderText = "\(scope.placeholderText)".styled(with: Const.captionPlaceholderStyle)
    node.style.flexGrow = 1
    node.style.flexShrink = 1
    return node
  }()

  lazy var limitedTextNode: ASTextNode = {
    let node = ASTextNode()
    node.attributedText = "0/\(scope.maxCount)".styled(with: Const.limitedStyle)
    return node
  }()

  func bind(reactor: FormCaptionReactor) {
    bindAction(reactor: reactor)
    bindState(reactor: reactor)
  }

  // MARK: Private

  private struct Const {
    static let captionPlaceholderStyle = StringStyle(.font(.systemFont(ofSize: 13)), .color(#colorLiteral(red: 0.5882352941, green: 0.5882352941, blue: 0.5882352941, alpha: 1)))
    static let captingTypingStyle = StringStyle(.font(.systemFont(ofSize: 13)), .color(.black))
    static let limitedStyle = StringStyle(.font(.systemFont(ofSize: 13)), .color(#colorLiteral(red: 0.5882352941, green: 0.5882352941, blue: 0.5882352941, alpha: 1)), .alignment(.right))
    static let contentsSpacing: CGFloat = 6
  }

}

// MARK: Reactor

extension FormCaptionNode {

  private func bindAction(reactor: FormCaptionReactor) {
    captionNode.textView.rx
      .attributedText
      .distinctUntilChanged()
      .filterNil()
      .withUnretained(captionNode)
      .subscribe(onNext: { owner, atrributedText in
        let width = owner.calculatedSize.width
        owner.style.height = .init(unit: .points, value: atrributedText.getHeight(containerWidth: width))
        owner.setNeedsLayout()
      })
      .disposed(by: disposeBag)

    captionNode.textView.rx
      .attributedText
      .distinctUntilChanged()
      .filterNil()
      .map { .typingText($0.string) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
  }

  private func bindState(reactor: FormCaptionReactor) {
    let state = reactor.state.share()

    state
      .map{ $0.currentTextRange }
      .distinctUntilChanged()
      .bind(to: currentTextRangeBinder)
      .disposed(by: disposeBag)

  }
}

// MARK: - Stream

extension FormCaptionNode {

  // MARK: Internal

  var isValidStream: Observable<Bool> {
    reactor?.state.map { $0.isValid } ?? .empty()
  }

  var textStream: Observable<String> {
    reactor?.state.map { $0.text } ?? .empty()
  }

  // MARK: Private

  private var currentTextRangeBinder: Binder<Int> {
    Binder(self, scheduler: CurrentThreadScheduler.instance) { base, count in
      base.limitedTextNode.attributedText = "\(count)/\(base.scope.maxCount)".styled(with: Const.captionPlaceholderStyle)
    }
  }

}

// MARK: - LayoutSpec

extension FormCaptionNode {

  // MARK: Internal

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .vertical,
      spacing: Const.contentsSpacing,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        captionNode,
        limitCaptionAreaLayoutSpec(),
      ])
  }

  // MARK: Private

  private func limitCaptionAreaLayoutSpec() -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .horizontal,
      spacing: .zero,
      justifyContent: .end,
      alignItems: .stretch,
      children: [
        limitedTextNode,
      ])
  }
}
