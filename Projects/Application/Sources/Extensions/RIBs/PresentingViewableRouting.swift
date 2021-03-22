import RIBs

// MARK: - PresentingViewableRouting

protocol PresentingViewableRouting {
  var presentedRoutings: [ViewableRouting] { get }

  func clearPresent(routings: [ViewableRouting], animated: Bool) -> [ViewableRouting]
  func present(routings: [ViewableRouting], routing: ViewableRouting, showAnimated: Bool) -> [ViewableRouting]
}

extension PresentingViewableRouting where Self: ViewableRouting {

  @discardableResult
  func clearPresent(routings: [ViewableRouting], animated: Bool) -> [ViewableRouting] {
    guard let viewControllable = self.viewControllable as? ViewControllable & UIViewControllerViewable else { return routings }

    routings.forEach{ detachChild($0) }
    viewControllable.dismiss(viewControllable: viewControllable, animated: animated)
    return []
  }

  func present(routings: [ViewableRouting], routing: ViewableRouting, showAnimated: Bool) -> [ViewableRouting] {
    guard let viewControllable = self.viewControllable as? ViewControllable & UIViewControllerViewable else { return routings }

    _ = clearPresent(routings: routings, animated: false)

    attachChild(routing)

    viewControllable.present(
      viewControllable: routing.viewControllable,
      isFullScreenSize: true,
      animated: showAnimated)

    return [routing]
  }
}
