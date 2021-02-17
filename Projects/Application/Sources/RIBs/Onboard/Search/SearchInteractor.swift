import RIBs
import RxSwift

// MARK: - SearchRouting

protocol SearchRouting: ViewableRouting {
}

// MARK: - SearchPresentable

protocol SearchPresentable: Presentable {
  var listener: SearchPresentableListener? { get set }
}

// MARK: - SearchListener

protocol SearchListener: AnyObject {
}

// MARK: - SearchInteractor

final class SearchInteractor: PresentableInteractor<SearchPresentable>, SearchInteractable, SearchPresentableListener {

  // MARK: Lifecycle

  override init(presenter: SearchPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  deinit {
    print("SearchInteractor deinit...")
  }

  // MARK: Internal

  weak var router: SearchRouting?
  weak var listener: SearchListener?

}
