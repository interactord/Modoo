import AsyncDisplayKit
import ReactorKit
import RIBs
import RxIGListKit
import RxOptional
import RxSwift
import RxTexture2
import RxViewController
import UIKit

// MARK: - SubFeedPresentableListener

protocol SubFeedPresentableListener: AnyObject {
  var action: ActionSubject<SubFeedDisplayModel.Action> { get }
  var state: Observable<SubFeedDisplayModel.State> { get }
}

// MARK: - SubFeedViewController

final class SubFeedViewController: ASDKViewController<SubFeedContainerNode>, SubFeedPresentable, SubFeedViewControllable {

  // MARK: Lifecycle

  deinit {
    print("SubFeedViewController deinit...")
  }

  // MARK: Internal

  let disposeBag = DisposeBag()

  lazy var adapter: ListAdapter = {
    let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    adapter.setASDKCollectionNode(node.collectionNode)
    return adapter
  }()

  lazy var dataSource: RxListAdapterDataSource<FeedSectionModel> = {
    weak var listener = self.listener
    return .init { _, object in
      switch object {
      case let .postContent(itemModel):
        return SectionController<SectionDisplayModel<EmptyItemModel, FeedContentSectionModel.Cell, EmptyItemModel>>(
          nodeForItemBlock: {
            let node = FeedPostCellNode(item: $0)
            if let listener = listener {
              node.commentTabStream
                .withUnretained(node)
                .map{ .tabComment($0.0.item) }
                .bind(to: listener.action)
                .disposed(by: node.disposeBag)
            }
            return node
          }
        )
      }
    }
  }()

  weak var listener: SubFeedPresentableListener? {
    didSet { bind(listener: listener) }
  }

  override func loadView() {
    super.loadView()
    view.backgroundColor = .white
  }

}

// MARK: ListenerBindable

extension SubFeedViewController: ListenerBindable {

  func bindAction(listener: SubFeedPresentableListener) {
    node.backButtonTabStream
      .mapTo(.tapClose)
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    rx.viewDidLoad
      .mapTo(.load)
      .bind(to: listener.action)
      .disposed(by: disposeBag)
  }

  func bindState(listener: SubFeedPresentableListener) {
    listener.state.map(\.cellModel.model.ownerUserName)
      .bind(to: node.titleUserNameBinder)
      .disposed(by: disposeBag)

    listener.state
      .map {[
        FeedSectionModel.postContent(itemModel: $0.postContentSectionModel),
      ]}
      .bind(to: adapter.rx.objects(for: dataSource))
      .disposed(by: disposeBag)

    // TODO: 해당 부분 로직은 차후에 개선이 필요합니다.
    listener.state
      .filter{ $0.focusIndex >= 0 && $0.postContentSectionModel.cellItems.count > $0.focusIndex }
      .do(onNext: { [weak self] _ in self?.node.collectionNode.isHidden = true })
      .delay(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
      .map{ IndexPath(item: $0.focusIndex, section: .zero) }
      .bind(to: node.scrollToItemBinder)
      .disposed(by: disposeBag)
  }
}
