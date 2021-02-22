import AsyncDisplayKit
import ReactorKit
import RIBs
import RxIGListKit
import RxSwift
import RxTexture2
import RxViewController
import UIKit

// MARK: - SearchPresentableAction

enum SearchPresentableAction: Equatable {
  case loading(Bool)
}

// MARK: - SearchPresentableListener

protocol SearchPresentableListener: AnyObject {
  typealias Action = SearchPresentableAction
  typealias State = SearchDisplayModel.State

  var action: ActionSubject<Action> { get }
  var state: Observable<State> { get }
  var currentState: State { get }
}

// MARK: - SearchViewController

final class SearchViewController: ASDKViewController<SearchContainerNode>, SearchPresentable, SearchViewControllable {

  // MARK: Lifecycle

  deinit {
    print("SearchViewController deinit...")
  }

  // MARK: Internal

  var items: [String] = Array(repeating: "1", count: 10)

  lazy var searchUserAdapter: ListAdapter = {
    let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    adapter.setASDKCollectionNode(node.searchUserCollectionNode)
    return adapter
  }()

  let disposeBag = DisposeBag()

  let searchUserDataSource = RxListAdapterDataSource<SearchUserSectionModel> { _, object in
    switch object {
    case let .userContent(itemModel):
      return SectionController<SearchUserContentSectionItemModel>(
        elementKindTypes: [],
        numberOfCellItemsBlock: { _ in 10 },
        nodeForItemBlock: { _, _ in SearchUserCellNode() })
    }
  }

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
