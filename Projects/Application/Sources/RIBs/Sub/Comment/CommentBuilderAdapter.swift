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
  func routeToBackFromComment() {
    listener?.routeToBackFromComment()
  }
}

// MARK: CommentBuildable

extension CommentBuilderAdapter: CommentBuildable {
  func build(withListener listener: CommentListener, item: FeedContentSectionModel.Cell) -> CommentRouting {
    let component = Component(dependency: dependency)
    self.listener = listener

    let builder = CommentBuilder(dependency: component)
    return builder.build(withListener: self, item: item)
  }

}
