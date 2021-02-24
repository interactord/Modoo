import RIBs

// MARK: - SearchInteractable

protocol SearchInteractable: Interactable, SubProfileListener {
  var router: SearchRouting? { get set }
  var listener: SearchListener? { get set }
}

// MARK: - SearchViewControllable

protocol SearchViewControllable: ViewControllable, UINavigationViewable {
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

  func routeToSubProfile(uid: String) {
    guard subProfileRouter == nil else { return }

    let subProfileRouter = subProfileBuilder.build(withListener: interactor, uid: uid)
    self.subProfileRouter = subProfileRouter
    attachChild(subProfileRouter)

    viewController.push(viewControllable: subProfileRouter.viewControllable, animated: true)
  }

  func routeToBack() {
    guard let subProfileRouter = subProfileRouter else { return }

    detachChild(subProfileRouter)
    self.subProfileRouter = nil
    viewController.pop(viewControllable: subProfileRouter.viewControllable, animated: true)
  }
}
