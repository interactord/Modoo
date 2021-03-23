import AsyncDisplayKit
import ReactorKit
import RIBs
import RxIGListKit
import RxOptional
import RxSwift
import RxTexture2
import RxViewController
import UIKit

// MARK: - CommentPresentableListener

protocol CommentPresentableListener: AnyObject {
  var action: ActionSubject<CommentDisplayModel.Action> { get }
  var state: Observable<CommentDisplayModel.State> { get }
}

// MARK: - CommentViewController

final class CommentViewController: ASDKViewController<CommentContainerNode>, CommentPresentable, CommentViewControllable {

  // MARK: Lifecycle

  deinit {
    print("CommentViewController deinit...")
  }

  // MARK: Internal

  weak var listener: CommentPresentableListener? {
    didSet { bind(listener: listener) }
  }

  // MARK: Private

  private lazy var adapter: ListAdapter = {
    let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    adapter.setASDKCollectionNode(node.collectionNode)
    return adapter
  }()

  private lazy var dataSource: RxListAdapterDataSource<CommentSectionModel> = {
    .init { _, object in
      switch object {
      case let .commentConent(itemModel):
        return SectionController<SectionDisplayModel<EmptyItemModel, CommentSectionItemModel.Cell, EmptyItemModel>>(
          sizeForItemWidthBlock: { UIScreen.main.bounds.width },
          nodeForItemBlock: { CommentCellNode(item: $0) })
      }
    }
  }()

  private let disposeBag = DisposeBag()
}

// MARK: ListenerBindable

extension CommentViewController: ListenerBindable {
  func bindAction(listener: CommentPresentableListener) {
    rx.viewDidLoad
      .mapTo(.load)
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    node
      .backButtonTapStream
      .mapTo(.back)
      .bind(to: listener.action)
      .disposed(by: disposeBag)
  }

  func bindState(listener: CommentPresentableListener) {
    listener.state
      .map{[
        CommentSectionModel.commentConent(itemModel: $0.commentSectionItemModel),
      ]}
      .bind(to: adapter.rx.objects(for: dataSource))
      .disposed(by: disposeBag)
  }
}
