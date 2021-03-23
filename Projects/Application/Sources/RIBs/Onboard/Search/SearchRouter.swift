import RIBs

// MARK: - SearchInteractable

protocol SearchInteractable: Interactable, SubProfileListener, SubFeedListener, CommentListener {
  var router: SearchRouting? { get set }
  var listener: SearchListener? { get set }
}

// MARK: - SearchViewControllable

protocol SearchViewControllable: ViewControllable, UIViewControllerViewable {
}

// MARK: - SearchRouter

final class SearchRouter: ViewableRouter<SearchInteractable, SearchViewControllable> {

  // MARK: Lifecycle

  init(
    interactor: SearchInteractable,
    viewController: SearchViewControllable,
    subProfileBuilder: SubProfileBuildable,
    subFeedBuilder: SubFeedBuildable)
  {
    defer { interactor.router = self }
    self.subProfileBuilder = subProfileBuilder
    self.subFeedBuilder = subFeedBuilder
    super.init(interactor: interactor, viewController: viewController)
  }

  deinit {
    print("SearchRouter deinit...")
  }

  // MARK: Internal

  let subProfileBuilder: SubProfileBuildable
  let subFeedBuilder: SubFeedBuildable
  var navigatingRoutings = [String: ViewableRouting]()

  // MARK: Private

  private struct Const {
    static let subProfileID = "subProfileID"
    static let subFeedID = "subFeedID"
  }
}

// MARK: SearchRouting, NavigatingViewableRouting

extension SearchRouter: SearchRouting, NavigatingViewableRouting {

  func routeToSubProfile(uid: String) {
    let router = subProfileBuilder.build(withListener: interactor, uid: uid)
    navigatingRoutings = push(router: router, id: Const.subProfileID)
  }

  func routeToSubFeed(model: ProfileContentSectionModel.Cell) {
    let router = subFeedBuilder.build(withListener: interactor, model: model)
    navigatingRoutings = push(router: router, id: Const.subFeedID)
  }

  func routeToBackFromSubFeed() {
    navigatingRoutings = pop(id: Const.subFeedID)
  }

  func routeToBackFromSubProfile() {
    navigatingRoutings = pop(id: Const.subProfileID)
  }
}
