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
}

// MARK: PostBuildable

extension PostBuilderAdapter: PostBuildable {
  func build(withListener listener: PostListener) -> PostRouting {
    let component = Component(dependency: dependency)
    self.listener = listener

    let builder = PostBuilder(dependency: component)
    return builder.build(withListener: self)
  }

}
