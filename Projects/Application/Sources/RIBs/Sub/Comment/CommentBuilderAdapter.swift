import RIBs

let CommentBuilderID = "CommentBuilderID"

// MARK: - CommentBuilderAdapter

final class CommentBuilderAdapter: Builder<CommentDependency> {

  // MARK: Lifecycle

  deinit {
    print("CommentBuilderAdapter deinit...")
  }

  // MARK: Private

  private final class Component: RIBs.Component<CommentDependency>, CommentDependency {
  }

  private weak var listener: CommentListener?

}

// MARK: CommentListener

extension CommentBuilderAdapter: CommentListener {
}

// MARK: CommentBuildable

extension CommentBuilderAdapter: CommentBuildable {
  func build(withListener listener: CommentListener) -> CommentRouting {
    let component = Component(dependency: dependency)
    self.listener = listener

    let builder = CommentBuilder(dependency: component)
    return builder.build(withListener: self)
  }

}
