import AsyncDisplayKit
import ReactorKit
import RIBs
import RxIGListKit
import RxOptional
import RxSwift
import RxTexture2
import RxViewController
import UIKit

// MARK: - SearchPresentableListener

protocol SearchPresentableListener: AnyObject {
  var action: ActionSubject<SearchDisplayModel.Action> { get }
  var state: Observable<SearchDisplayModel.State> { get }
}

// MARK: - SearchViewController

final class SearchViewController: ASDKViewController<SearchContainerNode>, SearchPresentable, SearchViewControllable {

  // MARK: Lifecycle

  deinit {
    print("SearchViewController deinit...")
  }

  // MARK: Internal

  lazy var searchUserAdapter: ListAdapter = {
    let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    adapter.setASDKCollectionNode(node.searchUserCollectionNode)
    return adapter
  }()

  let disposeBag = DisposeBag()

  lazy var searchUserDataSource: RxListAdapterDataSource<SearchUserSectionModel> = {
    weak var listener = self.listener
    return .init{ _, object in
      switch object {
      case let .userContent(itemModel):
        return SectionController<SearchUserContentSectionItemModel>(
          nodeForItemBlock: { SearchUserCellNode(item: $0) },
          selectedCellItemBlock: { item in
            listener?.action.onNext(.loadUser(item))
          })
      }
    }
  }()

  weak var listener: SearchPresentableListener? {
    didSet { bind(listener: listener) }
  }

}

extension SearchViewController {

  private func bind(listener: SearchPresentableListener?) {
    guard let listener = listener else { return }
    bindAction(listener: listener)
    bindState(listener: listener)
  }

  private func bindAction(listener: SearchPresentableListener) {
    rx.viewDidLoad
      .mapTo(.load)
      .bind(to: listener.action)
      .disposed(by: disposeBag)

    node.headerNode
      .searchTextStream?
      .map { .typingSearch($0) }
      .bind(to: listener.action)
      .disposed(by: disposeBag)
  }

  private func bindState(listener: SearchPresentableListener) {
    let state = listener.state.share()

    state
      .map{[
        SearchUserSectionModel.userContent(itemModel: $0.userContentSectionItemModel),
      ]}
      .bind(to: searchUserAdapter.rx.objects(for: searchUserDataSource))
      .disposed(by: disposeBag)
  }
}
