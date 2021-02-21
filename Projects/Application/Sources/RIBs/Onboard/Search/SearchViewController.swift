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

  lazy var searchUserAdapter: ListAdapter = {
    let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    adapter.setASDKCollectionNode(node.searchUserCollectionNode)
    return adapter
  }()

  let disposeBag = DisposeBag()

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
  }
}
