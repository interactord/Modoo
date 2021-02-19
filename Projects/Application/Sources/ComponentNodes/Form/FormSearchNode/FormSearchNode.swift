import AsyncDisplayKit
import BonMot
import ReactorKit
import RxCocoa
import RxKeyboard
import RxOptional
import RxSwift
import RxTexture2

// MARK: - FormSearchNode

final class FormSearchNode: ASDisplayNode, View {

  // MARK: Lifecycle

  override init() {
    defer { reactor = .init() }
    super.init()
    automaticallyManagesSubnodes = true
  }

  deinit {
    print("FormSearchNode deinit..")
  }

  // MARK: Internal

  var disposeBag = DisposeBag()

  let searchFieldNode: SearchFieldNode = {
    let node = SearchFieldNode()
    node.style.flexGrow = 1
    return node
  }()

  let cancelButtonNode: ASButtonNode = {
    let node = ASButtonNode()
    node.setAttributedTitle("Cancel".styled(with: Const.buttonStringStyle), for: .normal)
    node.contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 0)
    return node
  }()

  func bind(reactor: FormSearchReactor) {
    bindAction(reactor: reactor)
    bindState(reactor: reactor)
  }

  // MARK: Private

  private struct Const {
    static var buttonStringStyle =
      StringStyle(.font(.systemFont(ofSize: 13, weight: .semibold)), .color(.black))
  }

}

// LayoutSpec

extension FormSearchNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let contentElements = [searchFieldNode, cancelButtonNode].filter { !$0.isHidden }

    return ASStackLayoutSpec(
      direction: .horizontal,
      spacing: .zero,
      justifyContent: .start,
      alignItems: .center,
      children: contentElements)
  }
}

extension FormSearchNode {
  private func bindAction(reactor: FormSearchReactor) {

    cancelButtonNode.rx.tap
      .map{ "" }
      .bind(to: searchFieldNode.searchTextBinder)
      .disposed(by: disposeBag)

    cancelButtonNode.rx.tap.share()
      .map { .hideCancelButton }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

    cancelButtonNode.rx.tap
      .observe(on: MainScheduler.asyncInstance)
      .withUnretained(self)
      .subscribe(onNext: { owner, _ in
        owner.view.endEditing(true)
      })
      .disposed(by: disposeBag)

    searchFieldNode
      .editingDidBeginEventStream?
      .map { _ in .showCancelButton }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

    searchFieldNode
      .editingDidEndEventStream?
      .withUnretained(searchFieldNode)
      .observe(on: SerialDispatchQueueScheduler(qos: .default))
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { owner, _ in
        owner.view.endEditing(true)
      })
      .disposed(by: disposeBag)
  }

  private func bindState(reactor: FormSearchReactor) {
    reactor.state
      .map { !$0.isShowCancelButton }
      .distinctUntilChanged()
      .withUnretained(self)
      .subscribe(onNext: { owner, isHidden in
        owner.cancelButtonNode.rx.isHidden.onNext(isHidden)
        owner.setNeedsLayout()
      })
      .disposed(by: disposeBag)

  }
}

// MARK: SearchNodeViewable

extension FormSearchNode: SearchNodeViewable {
  var node: ASDisplayNode { self }

  var searchTextStream: Observable<String>? {
    searchFieldNode.searchTextStream
  }
}
