import RIBs

let PostBuilderID = "PostBuilderID"

// MARK: - PostBuilderAdapter

final class PostBuilderAdapter: Builder<PostDependency> {

  // MARK: Lifecycle

  deinit {
    print("PostBuilderAdapter deinit...")
  }

  // MARK: Private

  private final class Component: RIBs.Component<PostDependency>, PostDependency {
  }

  private weak var listener: PostListener?

}

// MARK: PostListener

extension PostBuilderAdapter: PostListener {
  func routeToClose() {
    listener?.routeToClose()
  }
}

// MARK: PostBuildable

extension PostBuilderAdapter: PostBuildable {
  func build(withListener listener: PostListener, image: UIImage) -> PostRouting {
    _ = Component(dependency: dependency)
    self.listener = listener

    let builder = PostBuilder(dependency: dependency)
    return builder.build(withListener: self, image: image)
  }

}
