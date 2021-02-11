import RIBs

let FeedBuilderID = "FeedBuilderID"

// MARK: - FeedBuilderAdapter

final class FeedBuilderAdapter: Builder<FeedDependency> {

  // MARK: Lifecycle

  deinit {
    print("FeedBuilderAdapter deinit")
  }

  // MARK: Private

  private final class Component: RIBs.Component<FeedDependency>, FeedDependency {
  }

  private weak var listener: FeedListener?

}

// MARK: FeedListener

extension FeedBuilderAdapter: FeedListener {
}

// MARK: FeedBuildable

extension FeedBuilderAdapter: FeedBuildable {

  func build(withListener listener: FeedListener) -> FeedRouting {
    let component = Component(dependency: dependency)
    self.listener = listener

    let builder = FeedBuilder(dependency: component)
    return builder.build(withListener: self)
  }

}
