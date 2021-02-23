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

final class SearchRouter: ViewableRouter<SearchInteractable, SearchViewControllable> {

  // MARK: Lifecycle

  init(
    interactor: SearchInteractable,
    viewController: SearchViewControllable,
    subProfileBuilder: SubProfileBuildable)
  {
    defer { interactor.router = self }
    self.subProfileBuilder = subProfileBuilder
    super.init(interactor: interactor, viewController: viewController)
  }

  deinit {
    print("SearchRouter deinit...")
  }

  // MARK: Internal

  let subProfileBuilder: SubProfileBuildable
  var subProfileRouter: SubProfileRouting?
}

// MARK: SearchRouting

extension SearchRouter: SearchRouting {

}
