import AsyncDisplayKit
import BonMot
import RxKeyboard
import RxSwift

// MARK: - PostBodyNode

final class PostBodyNode: ASScrollNode {

  // MARK: Lifecycle

  override init() {
    super.init()
    automaticallyManagesSubnodes = true
    automaticallyManagesContentSize = true

    observeKeyboard()
  }

  deinit {
    print("PostBodyNode deinit...")
  }

  // MARK: Internal

  let disposeBag = DisposeBag()
  let pictureNode: ASImageNode = {
    let node = ASImageNode()
    node.image = #imageLiteral(resourceName: "dummy-content-image")
    node.contentMode = .scaleToFill
    node.style.preferredSize = Const.pictureSize
    node.cornerRadius = Const.pictureCornerRadius
    return node
  }()

  let captionNode = FormCaptionNode(
    scope: .init(
      placeholderText: "Enter capion...",
      minCount: 10,
      maxCount: 200))

  // MARK: Private

  private struct Const {
    static let pictureSize = CGSize(width: 180, height: 180)
    static let pictureCornerRadius: CGFloat = 3.0
    static let contentPadding = UIEdgeInsets(top: 12, left: 12, bottom: 9, right: 12)
  }

  private let keyboardDismissEventNode = ASControlNode()
  private var keyboardVisibleHeight: CGFloat = 0.0

}

// MARK: - Binding

extension PostBodyNode {

  private func observeKeyboard() {
    keyboardDismissEventNode.rx
      .tap
      .withUnretained(view)
      .subscribe(onNext: {
        $0.0.endEditing(true)
      })
      .disposed(by: disposeBag)

    RxKeyboard.instance.visibleHeight
      .withUnretained(view)
      .drive(onNext: { $0.0.scrollWhenKeyboardEvent(height: $0.1) })
      .disposed(by: disposeBag)
  }
}

// MARK: - LayoutSpec

extension PostBodyNode {

  // MARK: Internal

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let aa = ASLayoutSpec()
    aa.style.flexGrow = 1

    let contentLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: 10.0,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        pictureAreaLayoutSpec(),
        captionNode,
        aa,
      ])

    let containerLayout = ASInsetLayoutSpec(insets: Const.contentPadding, child: contentLayout)

    return ASBackgroundLayoutSpec(child: containerLayout, background: keyboardDismissEventNode)
  }

  // MARK: Private

  private func pictureAreaLayoutSpec() -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .horizontal,
      spacing: .zero,
      justifyContent: .center,
      alignItems: .stretch,
      children: [
        pictureNode,
      ])
  }

}

// MARK: - Stream

extension PostBodyNode {
  var isValidStream: Observable<Bool> {
    captionNode.isValidStream
  }

  var textStream: Observable<String> {
    captionNode.textStream
  }

  var postImageBinder: Binder<UIImage> {
    Binder(self, scheduler: CurrentThreadScheduler.instance) { base, image in
      base.pictureNode.image = image
    }
  }
}
