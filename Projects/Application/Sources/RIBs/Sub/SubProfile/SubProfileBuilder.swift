import RIBs

// MARK: - SubProfileDependency

protocol SubProfileDependency: Dependency {
}

// MARK: - SubProfileComponent

final class SubProfileComponent: Component<SubProfileDependency> {
}

// MARK: - SubProfileBuildable

protocol SubProfileBuildable: Buildable {
  func build(withListener listener: SubProfileListener) -> SubProfileRouting
}

// MARK: - SubProfileBuilder

final class SubProfileBuilder: Builder<SubProfileDependency>, SubProfileBuildable {

  // MARK: Lifecycle

  override init(dependency: SubProfileDependency) {
    super.init(dependency: dependency)
  }

  deinit {
    print("SubProfileBuilder deinit...")
  }

  // MARK: Internal

  func build(withListener listener: SubProfileListener) -> SubProfileRouting {
    let component = SubProfileComponent(dependency: dependency)
    let viewController = SubProfileViewController()
    let interactor = SubProfileInteractor(presenter: viewController)
    interactor.listener = listener
    return SubProfileRouter(interactor: interactor, viewController: viewController)
  }
}
