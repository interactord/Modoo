import AsyncDisplayKit
import ReactorKit
import RIBs
import RxIGListKit
import RxOptional
import RxSwift
import RxTexture2
import RxViewController
import UIKit

// MARK: - FeedPresentableListener

protocol FeedPresentableListener: AnyObject {
  var action: ActionSubject<FeedDisplayModel.Action> { get }
  var state: Observable<FeedDisplayModel.State> { get }
  var currentState: FeedDisplayModel.State { get }
}

// MARK: - FeedViewController

final class FeedViewController: ASDKViewController<FeedContainerNode>, FeedPresentable, FeedViewControllable {

  // MARK: Lifecycle

  deinit {
    print("FeedViewController deinit...")
  }

  // MARK: Internal

  let disposeBag = DisposeBag()

  lazy var adapter: ListAdapter = {
    let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    adapter.setASDKCollectionNode(node.collectionNode)
    return adapter
  }()

  lazy var dataSource: RxListAdapterDataSource<FeedSectionModel> = {
    .init { _, object in
      switch object {
      case let .postContent(itemModel):
        return SectionController<PostContentSectionModel>(
          nodeForItemBlock: { FeedPostCellNode(item: $0) }
        )
      }
    }
  }()

  weak var listener: FeedPresentableListener? {
    didSet { bind(listener: listener) }
  }

}

// MARK: - Binder

extension FeedViewController {

  private func bind(listener: FeedPresentableListener?) {
    guard let listener = listener else { return }
    bindAction(listener: listener)
    bindState(listener: listener)
  }

  private func bindAction(listener: FeedPresentableListener) {
    rx.viewDidAppear
      .mapTo(.load)
      .bind(to: listener.action)
      .disposed(by: disposeBag)
  }

  private func bindState(listener: FeedPresentableListener) {
    let state = listener.state.share()

    state
      .map{[
        FeedSectionModel.postContent(itemModel: $0.postContentSectionModel),
      ]}
      .bind(to: adapter.rx.objects(for: dataSource))
      .disposed(by: disposeBag)
  }
}
