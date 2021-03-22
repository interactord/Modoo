import RIBs

// MARK: - CommentDependency

protocol CommentDependency: Dependency {
}

// MARK: - CommentComponent

final class CommentComponent: Component<CommentDependency> {
}

// MARK: - CommentBuildable

protocol CommentBuildable: Buildable {
  func build(withListener listener: CommentListener) -> CommentRouting
}

// MARK: - CommentBuilder

final class CommentBuilder: Builder<CommentDependency>, CommentBuildable {

  // MARK: Lifecycle

  override init(dependency: CommentDependency) {
    super.init(dependency: dependency)
  }

  deinit {
    print("CommentBuilder deinit...")
  }

  // MARK: Internal

  func build(withListener listener: CommentListener) -> CommentRouting {
    let component = CommentComponent(dependency: dependency)
    let viewController = CommentViewController()
    let interactor = CommentInteractor(presenter: viewController)
    interactor.listener = listener
    return CommentRouter(interactor: interactor, viewController: viewController)
  }
}
