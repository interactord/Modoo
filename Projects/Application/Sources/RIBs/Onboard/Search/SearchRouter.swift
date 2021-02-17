import RIBs

// MARK: - SearchInteractable

protocol SearchInteractable: Interactable {
  var router: SearchRouting? { get set }
  var listener: SearchListener? { get set }
}

// MARK: - SearchViewControllable

protocol SearchViewControllable: ViewControllable {
}

// MARK: - SearchRouter

final class SearchRouter: ViewableRouter<SearchInteractable, SearchViewControllable>, SearchRouting {

  override init(interactor: SearchInteractable, viewController: SearchViewControllable) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  deinit {
    print("SearchRouter deinit...")
  }
}
