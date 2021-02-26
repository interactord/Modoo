import AsyncDisplayKit
import RxSwift

// MARK: - PostContainerNode

final class PostContainerNode: ASDisplayNode {

  // MARK: Lifecycle

  override init() {
    super.init()

    automaticallyManagesSubnodes = true
    automaticallyRelayoutOnSafeAreaChanges = true
    backgroundColor = .white
    observeValidation()
  }

  deinit {
    print("PostContainerNode deinit...")
  }

  // MARK: Internal

  let headerNode = PostHeaderNode()
  lazy var bodyNode = PostBodyNode()
  let disposeBag = DisposeBag()
}

// MARK: - LayoutSpec

extension PostContainerNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentsLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: .zero,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        headerNode,
        bodyNode,
      ])

    return ASInsetLayoutSpec(
      insets: safeAreaInsets,
      child: contentsLayout)
  }
}

// MARK: - Binding

extension PostContainerNode {
  func observeValidation() {
    bodyNode
      .isValidStream
      .distinctUntilChanged()
      .bind(to: headerNode.shareButton.rx.isEnabled)
      .disposed(by: disposeBag)
  }
}

// MARK: - Stream

extension PostContainerNode {
  var cancelButtonTapStream: Observable<Void> {
    headerNode.cancelButton.rx.tap.asObservable()
  }

  var captionStream: Observable<String> {
    bodyNode.textStream
  }

  var postImageBinder: Binder<UIImage> {
    bodyNode.postImageBinder
  }

  var shareButtonTapStream: Observable<Void> {
    headerNode.shareButton.rx.tap.asObservable()
  }
}
