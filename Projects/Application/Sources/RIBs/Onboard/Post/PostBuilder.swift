import RIBs

// MARK: - PostDependency

protocol PostDependency: Dependency {
}

// MARK: - PostComponent

final class PostComponent: Component<PostDependency> {
}

// MARK: - PostBuildable

protocol PostBuildable: Buildable {
  func build(withListener listener: PostListener, image: UIImage) -> PostRouting
}

// MARK: - PostBuilder

final class PostBuilder: Builder<PostDependency>, PostBuildable {

  // MARK: Lifecycle

  override init(dependency: PostDependency) {
    super.init(dependency: dependency)
  }

  deinit {
    print("PostBuilder deinit...")
  }

  // MARK: Internal

  func build(withListener listener: PostListener, image: UIImage) -> PostRouting {
    _ = PostComponent(dependency: dependency)
    let viewController = PostViewController(node: .init())
    let interactor = PostInteractor(
      presenter: viewController,
      initialState: .init(photo: image, caption: "", isLoading: false, errorMessage: ""))
    interactor.listener = listener
    return PostRouter(interactor: interactor, viewController: viewController)
  }
}
