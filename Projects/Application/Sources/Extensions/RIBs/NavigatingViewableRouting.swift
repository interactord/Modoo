import RIBs

// MARK: - NavigatingViewableRouting

protocol NavigatingViewableRouting {
  var navigatingRoutings: [String: ViewableRouting] { get }

  func push(router: ViewableRouting, id: String) -> [String: ViewableRouting]
  func pop(id: String) -> [String: ViewableRouting]
}

extension NavigatingViewableRouting where Self: ViewableRouting {

  func push(router: ViewableRouting, id: String) -> [String: ViewableRouting] {
    guard let viewControllable = self.viewControllable as? ViewControllable & UIViewControllerViewable else { return navigatingRoutings }
    guard navigatingRoutings[id] == nil else { return navigatingRoutings }

    attachChild(router)
    viewControllable.push(viewControllable: router.viewControllable, animated: true)

    var newRoutings = navigatingRoutings
    newRoutings[id] = router
    return newRoutings
  }

  func pop(id: String) -> [String: ViewableRouting] {
    guard let viewControllable = self.viewControllable as? ViewControllable & UIViewControllerViewable else { return navigatingRoutings }
    guard let router = navigatingRoutings[id] else { return navigatingRoutings }

    detachChild(router)
    viewControllable.pop(viewControllable: router.viewControllable, animated: true)

    var newRoutings = navigatingRoutings
    newRoutings.removeValue(forKey: id)
    return newRoutings
  }
}
